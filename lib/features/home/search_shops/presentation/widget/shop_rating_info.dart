import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ShopRatingInfo extends StatelessWidget {
  const ShopRatingInfo(
      {super.key, required this.rate, required this.totalReviews});

  final double rate;
  final int totalReviews;

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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Assets.icons.shopIcons.star.image(
              width: 30,
              height: 30,
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
                    'Rating ${rate.toStringAsFixed(1)} ($totalReviews reviews)',
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
}
