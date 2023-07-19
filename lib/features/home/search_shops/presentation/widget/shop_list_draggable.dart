import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';

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
      initialChildSize: 0.65,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF2E2E2E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(100, 80),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.75,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      header(context),
                      Expanded(
                          child: Column(
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
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget header(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.06,
      child: Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Center(
          child: CustomText(
            text: title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.location_on_outlined,
                size: 30,
                color: Colors.red,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
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
