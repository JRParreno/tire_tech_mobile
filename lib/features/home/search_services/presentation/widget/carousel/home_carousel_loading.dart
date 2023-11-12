import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/shimmer.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class HomeCarouselLoading extends StatelessWidget {
  final Function(int value) onChanged;

  const HomeCarouselLoading({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      width: MediaQuery.of(context).size.width,
      child: Shimmer(
        linearGradient: AppConstant.shimmerGradient,
        child: ShimmerLoading(
          isLoading: true,
          child: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, idx) => Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * .85,
                  decoration: BoxDecoration(
                    color: ColorName.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                onChanged(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
