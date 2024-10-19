import 'package:easy_cha/core/constant/const_string.dart';
import 'package:easy_cha/feature/auth/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_cha/core/helper/api_service.dart';
import 'package:easy_cha/feature/auth/model/login_post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._apiService) : super(AuthInitial());
  final ApiService _apiService;
  final Box _box = Hive.box(ConstString.userBox);

  Future<void> login(LoginPostModel model) async {
    try {
      emit(AuthLoading());
      Map<String, dynamic> result = await _apiService.post(
        endPoint: ConstString.login,
        formData: model.toJson(),
      );
      ResponseModel response = ResponseModel.fromJson(result);
      await _saveUser(response.data);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthFailure("$e"));
      debugPrint("Login Error: $e");
    }
  }

  Future<void> _saveUser(UserModel? user) async {
    if (user == null) return;
    await _box.put(ConstString.userKey, user.toJson());
  }

  bool checkLogin() {
    final data = _box.get(ConstString.userKey, defaultValue: {});
    final Map<String, dynamic> user = Map.from(data);
    debugPrint("$user");
    return user.isEmpty;
  }
}
