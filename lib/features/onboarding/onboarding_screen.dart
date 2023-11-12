import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/account/login/presentation/screen/login_screen.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

import '../../core/common_widget/common_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding-screen';

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends State<OnBoardingScreen> {
  bool isAccepted = false;

  void handleNavigateLogin() {
    // Navigate to login screen
    Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
  }

  void onChangeCheckBox(bool? value) {
    setState(() {
      isAccepted = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: ColorName.primary,
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.icon.image(
                          height: 170,
                          width: 170,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const CustomText(
                                text: "Tire-TECH",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomText(
                                text:
                                    "Welcome to our automotive services tracking app! We understand how important it is to stay on top of routine maintenance for your vehicle, and our app is here to help make that process as easy and efficient as possible.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomText(
                                text:
                                    "With our app, you'll be able to track all of your automotive services, including oil changes, tire rotations, and more. You'll receive reminders when it's time to schedule your next service appointment if applicable;, and you can even find trusted local mechanics directly through our app.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomText(
                                text:
                                    "Our goal is to provide you with a seamless and stress-free experience when it comes to managing your vehicle's maintenance. We hope you find our app to be a valuable tool in keeping your car running smoothly for years to come.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isAccepted,
                                    onChanged: onChangeCheckBox,
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                  ),
                                  const Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Check the box to continue.",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                        text:
                                            "By  checking the box you agreed to our terms and condition while using the application.",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBtn(
                          backgroundColor: Colors.white,
                          label: "Get Started",
                          onTap: isAccepted ? handleNavigateLogin : () {},
                          width: 275,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
