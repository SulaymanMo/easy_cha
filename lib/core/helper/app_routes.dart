import 'package:easy_cha/core/helper/api_service.dart';
import 'package:easy_cha/core/helper/service_locator.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/auth/view/login_view.dart';
import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/home/manager/socket_manager/socket_cubit.dart';
import '../constant/const_string.dart';
import '../../feature/home/view/home_view.dart';

Route<dynamic> appRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(
                  getIt.get<ApiService>(),
                  context.read<AuthCubit>(),
                )..getUsers(),
              ),
              BlocProvider<SocketCubit>(
                create: (context) => SocketCubit(context.read<AuthCubit>()),
              ),
            ],
            child: const HomeView(),
          );
        },
      );
    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
