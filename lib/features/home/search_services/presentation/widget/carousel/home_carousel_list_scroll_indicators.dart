import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/carousel.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/carousel/home_carousel_indicator.dart';

class HomeCarouselListScrollIndicators extends StatelessWidget {
  final List<Carousel> carousels;
  final bool isLoading;
  final int currentCarousel;

  const HomeCarouselListScrollIndicators({
    super.key,
    required this.carousels,
    required this.isLoading,
    required this.currentCarousel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Center(
        child: isLoading
            ? ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    height: 10,
                    width: currentCarousel == index ? 32 : 10,
                    // width: 14,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              )
            : ListView.builder(
                itemCount: carousels.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HomeCarouselIndicator(
                    currentIndex: currentCarousel,
                    indicatorIndex: index,
                  );
                },
              ),
      ),
    );
  }
}
