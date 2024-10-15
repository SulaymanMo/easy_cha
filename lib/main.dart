import 'package:sizer/sizer.dart';
import 'core/constant/const_string.dart';
import 'core/helper/router_config.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, orientation, deviceType) {
        return MaterialApp(
          title: 'EasyCha',
          theme: lightTheme(),
          darkTheme: darkTheme(),
          onGenerateRoute: routes,
          initialRoute: Routes.home,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
