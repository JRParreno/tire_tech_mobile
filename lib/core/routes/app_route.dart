import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/account/login/presentation/screen/login_screen.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/change_password_screen.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/update_account_screen.dart';
import 'package:tire_tech_mobile/features/account/signup/presentation/screens/sign_up_screen.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/screen/search_services_screen.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/screen/search_shops_screen.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_image_gallery.dart';
import 'package:tire_tech_mobile/features/menu/presentation/screen/menu_screen.dart';
import 'package:tire_tech_mobile/features/review/presentation/screen/shop_add_update_review_screen.dart';
import 'package:tire_tech_mobile/features/review/presentation/screen/shop_review_screen.dart';

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
        case UpdateAccountScreen.routeName:
          return const UpdateAccountScreen();
        case ChangePasswordScreen.routeName:
          return const ChangePasswordScreen();
        case ShopReviewScreen.routeName:
          final args = settings.arguments! as ShopReviewScreenArgs;
          return ShopReviewScreen(
            args: args,
          );
        case ShopAddUpdateReviewScreen.routeName:
          final args = settings.arguments! as ShopAddUpdateReviewScreenArgs;
          return ShopAddUpdateReviewScreen(
            args: args,
          );

        case ImageDetailView.routeName:
          final args = settings.arguments! as ImageDetailViewArgs;
          return ImageDetailView(
            args: args,
          );

        case ShopImageSequenceView.routeName:
          final args = settings.arguments! as ShopImageSequenceViewArgs;
          return ShopImageSequenceView(
            args: args,
          );
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
