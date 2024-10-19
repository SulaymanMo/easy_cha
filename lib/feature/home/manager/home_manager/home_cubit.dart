import 'package:easy_cha/feature/auth/model/user_model.dart';
import 'package:easy_cha/feature/home/model/home_model.dart';
import 'package:easy_cha/feature/home/model/home_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_cha/core/helper/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constant/const_string.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late UserModel user;
  final ApiService _apiService;
  final Box _box = Hive.box(ConstString.userBox);
  HomeCubit(this._apiService) : super(HomeInitial());

  Future<void> getUsers() async {
    try {
      emit(HomeLoading());
      getLocalUser();
      final result = await _apiService.get(
        userid: "${user.id}",
        token: user.token,
        endPoint: ConstString.home,
      );
      HomeModel homeModel = HomeModel.fromJson(result);
      // debugPrint("${homeModel.data?.users?.length}");
      if (homeModel.data?.users != null) {
        emit(HomeSuccess(homeModel.data!.users!));
      }
    } catch (e) {
      debugPrint("$e");
      emit(HomeFailure("$e"));
    }
  }

  void getLocalUser() {
    final data = _box.get(ConstString.userKey, defaultValue: {});
    Map<String, dynamic> mapData = Map.from(data);
    user = UserModel.fromJson(mapData);
  }
}
