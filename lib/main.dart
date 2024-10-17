import 'package:easy_cha/core/helper/api_service.dart';
import 'package:easy_cha/core/helper/observer.dart';
import 'package:easy_cha/core/helper/service_locator.dart';
import 'package:easy_cha/feature/auth/manager/auth_cubit.dart';
import 'package:easy_cha/feature/home/manager/socket_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'core/constant/const_string.dart';
import 'core/helper/app_routes.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // ! _____ App Setup & Initialization _____ ! //
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  setupServiceLocator();
  await Hive.initFlutter();
  // ! _____ Hive Box _____ ! //
  await Hive.openBox<Map<String, dynamic>>(ConstString.userBox);
  // final box = Hive.box<Map<String, dynamic>>(ConstString.userBox);
  // final user = box.get(ConstString.userKey, defaultValue: {});
  // if (user != null && user.isNotEmpty) UserModel.fromJson(user);
  // print(user);
  // ! _____
  runApp(
    BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(getIt.get<ApiService>()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SocketCubit>(create: (_) => SocketCubit()),
          ],
          child: MaterialApp(
            title: 'EasyCha',
            theme: lightTheme(),
            darkTheme: darkTheme(),
            onGenerateRoute: appRoutes,
            initialRoute: context.read<AuthCubit>().checkAuth() != null
                ? Routes.home
                : Routes.login,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
