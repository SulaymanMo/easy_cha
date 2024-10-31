import 'package:dio/dio.dart';
import 'package:easy_cha/core/constant/const_string.dart';
import 'package:easy_cha/core/helper/failure.dart';
import 'package:easy_cha/feature/auth/model/response_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_cha/core/service/api_service.dart';
import 'package:easy_cha/feature/auth/model/login_post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  UserModel? user;
  final ApiService _apiService;
  final Box _box = Hive.box(ConstString.userBox);
  AuthCubit(this._apiService) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        Map<String, dynamic> result = await _apiService.postFormData(
          endPoint: ConstString.login,
          formData: LoginPostModel(
            email: email,
            password: password,
            deviceToken: token,
          ).toJson(),
        );
        ResponseModel response = ResponseModel.fromJson(result);
        await _saveUser(response.data);
        if (response.data != null) {
          emit(AuthSuccess(response.data!));
        } else {
          emit(AuthFailure("Error"));
        }
      }
    } on DioException catch (dioexp) {
      DioFailure(dioexp);
      emit(AuthFailure(DioFailure(dioexp).error));
    } catch (e) {
      emit(AuthFailure("Unexpected error occurred. Please try again later"));
    }
  }

  Future<void> _saveUser(UserModel? user) async {
    if (user == null) return;
    this.user = user;
    await _box.put(ConstString.userKey, user.toJson());
  }

  bool checkLogin() {
    final data = _box.get(ConstString.userKey, defaultValue: {});
    final Map<String, dynamic> mapData = Map.from(data);
    if (mapData.isNotEmpty) {
      user = UserModel.fromJson(mapData);
    } else if (true) {}
    return mapData.isEmpty;
  }

  Future<void> logout() async => await _box.clear();
}
