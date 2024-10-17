import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_cha/core/helper/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constant/const_string.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService;
  final _box = Hive.box<Map<String, dynamic>>(ConstString.userBox);
  HomeCubit(this._apiService) : super(HomeInitial());

  Future<void> getUsers() async {
    try {
      Map<String, dynamic>? user = getLocalUser();
      if (user == null) return;
      final result = await _apiService.get(
        token: user[""],
        userid: user[""],
        endPoint: "api/home",
      );
      debugPrint("result $result");
    } catch (e) {
      debugPrint("$e");
    }
  }

  Map<String, dynamic>? getLocalUser() => _box.get(ConstString.userKey);
}
