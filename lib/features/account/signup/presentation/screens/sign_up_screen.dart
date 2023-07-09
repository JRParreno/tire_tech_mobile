import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tire_tech_mobile/core/common_widget/common_dialog.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/features/account/signup/data/models/signup.dart';
import 'package:tire_tech_mobile/features/account/signup/data/repositories/signup_repository_impl.dart';
import 'package:tire_tech_mobile/features/account/signup/presentation/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailSignupCtrl = TextEditingController();
  final TextEditingController passwordSignupCtrl = TextEditingController();
  final TextEditingController mobileNoCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController completeAddressCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();

  final signupFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;

  @override
  void initState() {
    handleTestValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
            top: 50,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.only(topLeft: Radius.elliptical(100, 80)),
          ),
          child: SingleChildScrollView(
            child: SignupForm(
              onSelectGender: (value) {
                genderCtrl.value = TextEditingController.fromValue(
                        TextEditingValue(text: value))
                    .value;
              },
              genderCtrl: genderCtrl,
              firstNameCtrl: firstNameCtrl,
              lastNameCtrl: lastNameCtrl,
              emailCtrl: emailSignupCtrl,
              passwordCtrl: passwordSignupCtrl,
              completeAddressCtrl: completeAddressCtrl,
              confirmPasswordCtrl: confirmPasswordCtrl,
              mobileNoCtrl: mobileNoCtrl,
              formKey: signupFormKey,
              onSubmit: handleSignup,
              confirmPasswordVisible: _passwordConfirmVisible,
              confirmSuffixIcon: GestureDetector(
                onTap: handleOnConfirmChangePassVisible,
                child: Icon(!_passwordConfirmVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              passwordVisible: _passwordVisible,
              suffixIcon: GestureDetector(
                onTap: handleOnChangePassVisible,
                child: Icon(!_passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleTestValues() {
    emailSignupCtrl.text = 'juandelacruz@gmail.com';
    passwordSignupCtrl.text = '2020Rtutest@';
    mobileNoCtrl.text = '09321764095';
    confirmPasswordCtrl.text = '2021Rtutest@';
    completeAddressCtrl.text = '1977 FB HARRISON PASAY';
    firstNameCtrl.text = 'juan';
    lastNameCtrl.text = 'dela cruz';
    genderCtrl.text = 'male';
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void handleOnConfirmChangePassVisible() {
    setState(() {
      _passwordConfirmVisible = !_passwordConfirmVisible;
    });
  }

  void handleSignup() {
    if (signupFormKey.currentState!.validate()) {
      EasyLoading.show();

      final signup = Signup(
        email: emailSignupCtrl.text,
        mobileNumber: mobileNoCtrl.text,
        completeAddress: completeAddressCtrl.text,
        password: passwordSignupCtrl.text,
        confirmPassword: confirmPasswordCtrl.text,
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        gender: genderCtrl.text.toLowerCase() == 'male' ? "M" : "F",
      );
      SignupImpl().register(signup).then((value) {
        EasyLoading.dismiss();

        Future.delayed(const Duration(milliseconds: 500), () {
          // Navigate homescreen
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
    } else {}
  }
}
