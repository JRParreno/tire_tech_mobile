import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class HomeCarouselIndicator extends StatelessWidget {
  final int currentIndex;
  final int indicatorIndex;

  const HomeCarouselIndicator({
    super.key,
    required this.currentIndex,
    required this.indicatorIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 10),
      width: 10,
      decoration: BoxDecoration(
        color: currentIndex == indicatorIndex ? Colors.black : ColorName.gray,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
