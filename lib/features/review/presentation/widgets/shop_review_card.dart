import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_rating.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ShopReviewCard extends StatelessWidget {
  const ShopReviewCard({
    super.key,
    required this.shopReview,
    this.isEdit = false,
    this.onTap,
  });

  final ShopReview shopReview;
  final bool isEdit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: ColorName.dimGray,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: censor(shopReview.fullName)),
                if (isEdit) ...[
                  GestureDetector(
                    onTap: onTap,
                    child: const Icon(Icons.edit),
                  ),
                ]
              ],
            ),
            ShopRating(
              rate: shopReview.rate.toDouble(),
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            ),
            const Divider(),
            CustomText(text: shopReview.description),
          ],
        ),
      ),
    );
  }

  String censor(String original) {
    final splitName = original.split(' ');

    final name = splitName.map((e) => maskName(e)).toList();

    return name.join(' ');
  }

  String maskName(String splitName) {
    String newValue = '';
    final tempLength = splitName.length > 3 ? 2 : 1;
    for (int i = 0; i < splitName.length; i++) {
      newValue += tempLength < i ? splitName[i] : '*';
    }

    return newValue;
  }
}
