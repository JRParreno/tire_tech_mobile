import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/account/login/presentation/screen/login_screen.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:tire_tech_mobile/features/account/signup/presentation/screens/sign_up_screen.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/screen/search_services_screen.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/screen/search_shops_screen.dart';
import 'package:tire_tech_mobile/features/menu/presentation/screen/menu_screen.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case LoginScreen.routeName:
          return const LoginScreen();
        case SignUpScreen.routeName:
          return const SignUpScreen();
        case SearchServicesScreen.routeName:
          return const SearchServicesScreen();
        case SearchShopsScreen.routeName:
          final args = settings.arguments! as SearchShopsArgs;
          return SearchShopsScreen(
            args: args,
          );
        case MenuScreen.routeName:
          return const MenuScreen();
        case ProfileScreen.routeName:
          return const ProfileScreen();
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
