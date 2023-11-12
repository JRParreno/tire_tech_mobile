import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/utils/profile_utils.dart';
import 'package:tire_tech_mobile/core/utils/spacing/v_space.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class MenuScreen extends StatefulWidget {
  static const String routeName = 'menu-screen';

  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(
        context: context,
        title: '',
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Options',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Tracking informations",
                  onTap: () => {},
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Account Profile",
                  onTap: () =>
                      Navigator.of(context).pushNamed(ProfileScreen.routeName),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Logout",
                  onTap: () => ProfileUtils.handleLogout(context),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Vspace.lg,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
