import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_image_gallery.dart';

class ShopGalleryBtn extends StatelessWidget {
  const ShopGalleryBtn({
    super.key,
    required this.shopName,
    required this.photoUrls,
  });

  final String shopName;
  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 60,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: CustomBtn(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ShopImageSequenceView.routeName,
                  arguments: ShopImageSequenceViewArgs(
                    shopName: shopName,
                    photoUrls: photoUrls,
                  ),
                );
              },
              label: 'Shop Gallery',
            ),
          )
        ],
      ),
    );
  }
}
