import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_cha/core/service/api_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // ! _____ Api Service _____ ! //
  getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));
}
