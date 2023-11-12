import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/body/profile_icon.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/screen/services_search_screen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ServicesAppBar extends StatelessWidget {
  const ServicesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.primary,
      height: 60,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ProfileIcon(),
          const CustomText(
            text: 'Tire-TECH',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchServicesScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.only(top: 0),
              backgroundColor: Colors.white, // <-- Button color
            ),
            child: const Center(
                child: Icon(
              Icons.search,
              color: ColorName.primary,
              size: 20,
            )),
          )
        ],
      ),
    );
  }
}
