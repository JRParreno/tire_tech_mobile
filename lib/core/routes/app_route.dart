import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/account/login/presentation/screen/login_screen.dart';
import 'package:tire_tech_mobile/features/account/signup/presentation/screens/sign_up_screen.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case LoginScreen.routeName:
          return const LoginScreen();
        case SignUpScreen.routeName:
          return const SignUpScreen();
      }

      return const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Center(
          child: Text('no screen'),
        ),
      );
    },
  );
}
