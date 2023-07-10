import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_event.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/core/local_storage/local_storage.dart';
import 'package:tire_tech_mobile/core/routes/app_route.dart';
import 'package:tire_tech_mobile/features/account/profile/data/models/profile.dart';
import 'package:tire_tech_mobile/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/screen/search_services_screen.dart';
import 'package:tire_tech_mobile/features/onboarding/onboarding_screen.dart';

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
      setProfileBloc(profile: userProfile, ctx: ctx);
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
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
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (ctx, state) {
          initialization(ctx);

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: ((context, child) {
              return MaterialApp(
                navigatorKey: TireTechApp.navKey,
                builder: EasyLoading.init(),
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                onGenerateRoute: generateRoute,
                home: state is ProfileLoaded && !state.profile!.isNewRegister
                    ? const SearchServicesScreen()
                    : const OnBoardingScreen(),
              );
            }),
          );
        },
      ),
    );
  }
}
