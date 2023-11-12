import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_event.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/core/local_storage/local_storage.dart';
import 'package:tire_tech_mobile/core/routes/app_route.dart';
import 'package:tire_tech_mobile/features/account/profile/data/models/profile.dart';
import 'package:tire_tech_mobile/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/carousel/carousel_repository_impl.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/recent_searches/recent_search_repository_impl.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/home_carousel/home_carousel_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/recent_service_searches/recent_service_searches_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/screen/services_screen.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';
import 'package:tire_tech_mobile/features/onboarding/onboarding_screen.dart';
import 'package:tire_tech_mobile/features/review/data/repository/shop_review_repository_impl.dart';

class TireTechApp extends StatefulWidget {
  const TireTechApp({super.key});
  static final navKey = GlobalKey<NavigatorState>();

  @override
  State<TireTechApp> createState() => _TireTechAppState();
}

class _TireTechAppState extends State<TireTechApp> {
  @override
  void initState() {
    super.initState();
  }

  void initialization(BuildContext ctx) async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final userProfile = await ProfileRepositoryImpl().fetchProfile();
      // ignore: use_build_context_synchronously
      setProfileBloc(profile: userProfile, ctx: ctx);
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      // ignore: use_build_context_synchronously
      setProfileBloc(profile: null, ctx: ctx);
    }
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  void setProfileBloc({
    Profile? profile,
    required BuildContext ctx,
  }) {
    if (profile != null) {
      BlocProvider.of<ProfileBloc>(ctx).add(
        SetProfileEvent(profile: profile),
      );
    } else {
      BlocProvider.of<ProfileBloc>(ctx).add(
        const InitialEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ProfileBloc()),
        BlocProvider(create: (ctx) => UploadIdBloc()),
        BlocProvider<RecentServiceSearchesBloc>(
          create: (context) => RecentServiceSearchesBloc(
            RecentSearchRepositoryImpl(),
          ),
        ),
        BlocProvider<HomeCarouselBloc>(
          create: (context) => HomeCarouselBloc(
            CarouselRepositoryImpl(),
          ),
        ),
        BlocProvider(
            create: (ctx) => ShopReviewBloc(ShopReviewRepositoryImpl())),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (ctx, state) {
          final isProfileLoaded =
              state is ProfileLoaded && !state.profile!.isNewRegister;
          if (isProfileLoaded || state is InitialState) {
            initialization(ctx);
          }

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            builder: ((context, child) {
              return MaterialApp(
                navigatorKey: TireTechApp.navKey,
                builder: EasyLoading.init(),
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                onGenerateRoute: generateRoute,
                home: isProfileLoaded
                    ? const ServicesScreen()
                    : const OnBoardingScreen(),
              );
            }),
          );
        },
      ),
    );
  }
}
