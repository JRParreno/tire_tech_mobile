import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/utils/profile_utils.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/profile_screen.dart';

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
      appBar: buildAppBar(context: context, title: 'Menu'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.black54.withOpacity(.75),
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Data Sharing Options",
                  onTap: () => {},
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Data Storage and Protection",
                  onTap: () => {},
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "OPT-OUT Options",
                  onTap: () => {},
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Tracking informations",
                  onTap: () => {},
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Privacy Regulations",
                  onTap: () => {},
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Profile",
                  onTap: () =>
                      Navigator.of(context).pushNamed(ProfileScreen.routeName),
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: "Logout",
                  onTap: () => ProfileUtils.handleLogout(context),
                  backgroundColor: Colors.white.withOpacity(0.4),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
