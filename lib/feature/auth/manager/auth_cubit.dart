import 'package:easy_cha/core/constant/const_string.dart';
import 'package:easy_cha/feature/auth/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_cha/core/helper/api_service.dart';
import 'package:easy_cha/feature/auth/model/login_post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._apiService) : super(AuthInitial());
  final ApiService _apiService;
  final _box = Hive.box<Map<String, dynamic>>(ConstString.userBox);

  bool? checkAuth() {
    Map<String, dynamic>? data = _box.get(ConstString.userKey);
    return data?.isEmpty;
  }

  Future<void> login(LoginPostModel model) async {
    try {
      emit(AuthLoading());
      Map<String, dynamic> result = await _apiService.post(
        endPoint: ConstString.login,
        formData: model.toJson(),
      );
      await _saveUserAuth(result);
      ResponseModel response = ResponseModel.fromJson(result);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthFailure("$e"));
      debugPrint("Login Error: $e");
    }
  }

  Future<void> _saveUserAuth(Map<String, dynamic> result) async {
    await _box.put(ConstString.userKey, result);
  }
}
