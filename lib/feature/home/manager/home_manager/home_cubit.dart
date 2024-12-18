import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_cha/core/helper/failure.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/auth/model/user_model.dart';
import 'package:easy_cha/feature/home/model/home_model/home_model.dart';
import 'package:easy_cha/feature/home/model/home_model/home_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_cha/core/service/api_service.dart';
import '../../../../core/constant/const_string.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late UserModel _user;
  final ApiService _apiService;
  List<HomeUserModel> users = [];
  HomeCubit(this._apiService, AuthCubit cubit) : super(HomeInitial()) {
    _user = cubit.user!;
  }

  Future<void> getUsers() async {
    try {
      emit(HomeLoading());
      final result = await _apiService.get(
        userid: "${_user.id}",
        token: _user.token,
        endPoint: ConstString.home,
      );
      HomeModel homeModel = HomeModel.fromJson(result);
      // debugPrint("${homeModel.data?.users?.length}");
      if (homeModel.data?.users != null) {
        users = homeModel.data!.users!;
        emit(HomeSuccess(users));
      }
    } on DioException catch (dioexp) {
      emit(HomeFailure(DioFailure(dioexp).error));
    } catch (e) {
      emit(HomeFailure("Unexpected error occurred. Please try again later."));
    }
  }
}
