import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/shimmer.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/carousel.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class CustomCarousel extends StatelessWidget {
  final Carousel carousel;
  final VoidCallback onTap;
  final bool isNetWorkImage;

  const CustomCarousel({
    super.key,
    required this.carousel,
    required this.onTap,
    this.isNetWorkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: carousel.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: CustomText(
                          text: carousel.description,
                          style: const TextStyle(
                            color: ColorName.placeHolder,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: isNetWorkImage
                        ? CachedNetworkImage(
                            imageUrl: carousel.imageUrl.isNotEmpty
                                ? carousel.imageUrl
                                : "",
                            placeholder: (context, url) => Shimmer(
                              linearGradient: AppConstant.shimmerGradient,
                              child: ShimmerLoading(
                                  isLoading: true,
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width *
                                          .85,
                                      decoration: BoxDecoration(
                                        color: ColorName.primary,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  )),
                            ),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            carousel.imageUrl,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
