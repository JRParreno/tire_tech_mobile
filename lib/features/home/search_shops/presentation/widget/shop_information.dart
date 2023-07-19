import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';

class ShopInformation extends StatelessWidget {
  const ShopInformation({super.key, required this.shop});

  final Shop shop;

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
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (shop.services.isNotEmpty) ...[
                    iterableInfoWithTitle(
                      title: 'Services Offer',
                      description: shop.serviceDescription ?? '',
                      items: shop.services.map((e) => e.serviceName).toList(),
                    ),
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  if (shop.products.isNotEmpty) ...[
                    iterableInfoWithTitle(
                      title: 'Products',
                      description: shop.productDescription ?? '',
                      items: shop.products.map((e) => e.productName).toList(),
                    ),
                  ],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget iterableInfoWithTitle({
    required String title,
    required String description,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomText(
          text: description,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return CustomText(
              text: '  * ${items[index]}',
              style: const TextStyle(
                color: Colors.black,
              ),
            );
          },
        )
      ],
    );
  }
}
