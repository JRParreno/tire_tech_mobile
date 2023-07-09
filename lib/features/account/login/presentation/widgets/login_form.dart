import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/account/signup/presentation/screens/sign_up_screen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

import '../../../../../core/common_widget/common_widget.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Widget suffixIcon;
  final bool passwordVisible;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.suffixIcon,
    required this.passwordVisible,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 45,
        right: 45,
        top: 45,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.elliptical(100, 80)),
      ),
      child: Column(
        children: [
          const CustomText(
            text: 'Login',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const CustomText(
            text: 'Sing in to continue',
            style: TextStyle(
              fontSize: 14,
              color: ColorName.placeHolder,
            ),
          ),
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 20,
                    ),
                    CustomTextField(
                      textController: emailController,
                      labelText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      padding: EdgeInsets.zero,
                      parametersValidate: 'required',
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    CustomTextField(
                      textController: passwordController,
                      labelText: "Password",
                      padding: EdgeInsets.zero,
                      parametersValidate: 'required',
                      suffixIcon: suffixIcon,
                      obscureText: passwordVisible,
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomBtn(
                          label: "Log In",
                          onTap: onSubmit,
                          width: 275,
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      const CustomTextLink(
                        text: "Forgot Password?",
                        style: TextStyle(
                          color: ColorName.placeHolder,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => handleNavigateSignup(context),
                        child: const CustomTextLink(
                          text: "Signup!",
                          style: TextStyle(
                            color: ColorName.placeHolder,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleNavigateSignup(BuildContext context) {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }
}
