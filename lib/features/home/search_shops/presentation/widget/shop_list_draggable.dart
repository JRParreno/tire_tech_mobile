import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class ShopListDraggable extends StatelessWidget {
  const ShopListDraggable({
    super.key,
    required this.shops,
    required this.onTap,
    required this.title,
  });

  final List<Shop> shops;
  final Function(Shop shop) onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .4,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  child: Container(
                    height: 4,
                    width: 32,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    header(context),
                    Column(
                      children: [
                        if (shops.isEmpty) ...[
                          const ListTile(
                            dense: true,
                            title: Center(
                              child: Text(
                                'No shops found',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ] else ...[
                          CustomScrollView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount: shops.length,
                                  (context, index) {
                                    final shop = shops[index];
                                    return shopTile(shop);
                                  },
                                ),
                              ),
                            ],
                          )
                        ]
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget header(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: Center(
        child: CustomText(
          text: title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget shopTile(Shop shop) {
    return GestureDetector(
      onTap: () => onTap(shop),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Assets.icons.shopIcons.outputOnlinepngtools
                  .image(height: 55, width: 55),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorName.primary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: shop.shopName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomText(
                      text: 'Click to see service details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
