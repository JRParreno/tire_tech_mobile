import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/utils/profile_utils.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/update_account_screen.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/widgets/review_report/review_report_form.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController reviewCtrl = TextEditingController();
  final TextEditingController reportCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profile = ProfileUtils.userProfile(context);

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Profile'),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.black54.withOpacity(.75),
            ),
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const CustomText(
                  text: 'User Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                CustomText(
                  text: '${profile?.firstName} ${profile?.lastName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: handleNavigateEditProfile,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomText(
                      text: 'Click to edit profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(
                        text: 'Account Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: profile?.email ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: profile?.contactNumber ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Reviews & Reports',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ReviewReportForm(
                        reviewCtrl: reviewCtrl,
                        reportCtrl: reportCtrl,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      CustomText(
                        text: 'About us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleNavigateEditProfile() {
    Navigator.of(context).pushNamed(UpdateAccountScreen.routeName);
  }
}
