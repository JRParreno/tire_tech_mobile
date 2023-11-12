import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ShopOpenCloseTime extends StatelessWidget {
  const ShopOpenCloseTime({
    super.key,
    required this.openTime,
    required this.closeTime,
  });

  final String openTime;
  final String closeTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Assets.icons.shopIcons.time.image(
              width: 25,
              height: 25,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorName.primary,
              ),
              child: CustomText(
                text:
                    '${formattedTime(openTime)} - ${formattedTime(closeTime)}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String formattedTime(String value) {
    final String tempDate = '2023-11-12 $value';

    final dateFormat = DateFormat('hh:mm a');

    return dateFormat.format(DateTime.parse(tempDate));
  }
}
