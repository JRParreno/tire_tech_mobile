import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_rating.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({
    super.key,
    required this.shop,
    required this.rate,
  });

  final Shop shop;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.10,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    Assets.icons.shopIcons.carService
                        .image(height: 30, width: 30),
                    const SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: shop.shopName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ShopRating(rate: rate),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () =>
                      handleOpenMap(LatLng(shop.latitude, shop.longitude)),
                  child: const Icon(
                    Icons.location_pin,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => handleMakePhoneCall(shop.contactNumber),
                  child: const Icon(
                    Icons.phone,
                    size: 30,
                    color: Color(0xFF00BF63),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleMakePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> handleOpenMap(LatLng latLng) async {
    var uri = Uri.parse(
        "google.navigation:q=${latLng.latitude},${latLng.longitude}&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
