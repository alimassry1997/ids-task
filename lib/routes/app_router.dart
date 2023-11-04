import 'package:flutter/material.dart';
import 'package:idstask/routes/routes.dart';
import 'package:idstask/screens/home_screen/home_screen.dart';
import 'package:idstask/screens/login_screen/login_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
