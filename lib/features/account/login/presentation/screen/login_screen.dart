import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/core/common_widget/common_dialog.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/core/local_storage/local_storage.dart';
import 'package:tire_tech_mobile/features/account/login/data/repositories/login_repository_impl.dart';
import 'package:tire_tech_mobile/features/account/login/presentation/widgets/login_form.dart';
import 'package:tire_tech_mobile/features/account/profile/data/models/profile.dart';
import 'package:tire_tech_mobile/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/screen/search_services_screen.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    testLoginValues();
    // testSignupValues();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: height * .30,
                child: Center(
                  child: Assets.images.icon.image(
                    height: 170,
                    width: 170,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: LoginForm(
                  emailController: emailCtrl,
                  formKey: loginFormKey,
                  passwordController: passwordCtrl,
                  passwordVisible: _passwordVisible,
                  onSubmit: handleLogin,
                  suffixIcon: GestureDetector(
                    onTap: handleOnChangePassVisible,
                    child: Icon(!_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      EasyLoading.show();

      LoginRepositoryImpl()
          .login(email: emailCtrl.value.text, password: passwordCtrl.value.text)
          .then((value) async {
        await LocalStorage.storeLocalStorage(
            '_token', value['data']['access_token']);
        await LocalStorage.storeLocalStorage(
            '_refreshToken', value['data']['refresh_token']);
        handleGetProfile();
      }).catchError((onError) {
        EasyLoading.dismiss();

        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
            context: context,
            title: AppConstant.appName,
            body: "Invalid email or password",
            isError: true,
          );
        });
      });
    }
  }

  void testLoginValues() {
    emailCtrl.text = "jhonrhayparreno22@gmail.com";
    passwordCtrl.text = "2020Rtutest@";
  }

  void handleGetProfile() async {
    await ProfileRepositoryImpl().fetchProfile().then((profile) async {
      EasyLoading.dismiss();

      handleSetProfileBloc(profile);
      await LocalStorage.storeLocalStorage('_user', profile.toJson());

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          SearchServicesScreen.routeName,
          (route) => false,
        );
      });
    }).catchError((onError) {
      EasyLoading.dismiss();
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: AppConstant.appName,
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
  }

  void handleSetProfileBloc(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).add(
      SetProfileEvent(profile: profile),
    );
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
