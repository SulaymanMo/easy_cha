import 'package:flutter/material.dart';
import '../constant/const_string.dart';
import '../../feature/home/view/home_view.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const HomeView());
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
