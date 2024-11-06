import 'package:easy_cha/core/service/api_service.dart';
import 'package:easy_cha/core/helper/service_locator.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/auth/view/login_view.dart';
import 'package:easy_cha/feature/home/manager/msg_manager/msg_cubit.dart';
import 'package:easy_cha/feature/home/manager/typing_msg_manager/typing_cubit.dart';
import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:easy_cha/feature/home/manager/socket_manager/socket_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                ),
              ),
              BlocProvider<TypingMsgCubit>(
                create: (context) => TypingMsgCubit(
                  context.read<SocketCubit>(),
                )..isReceiverTyping(),
              ),
              BlocProvider<MsgCubit>(
                create: (context) => MsgCubit(
                  context.read<SocketCubit>(),
                  context.read<HomeCubit>(),
                ),
              ),
              // BlocProvider<FileCubit>(
              //   create: (context) => FileCubit(),
              // ),
            ],
            child: const HomeView(),
          );
        },
      );
    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
      );
    // case Routes.chat:
    //   return MaterialPageRoute(
    //     builder: (context) => ChatView(
    //       settings.arguments as HomeUserModel,
    //       settings.arguments as int,
    //     ),
    //   );
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
