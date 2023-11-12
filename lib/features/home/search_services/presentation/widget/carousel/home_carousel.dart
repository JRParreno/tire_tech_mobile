import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/carousel.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/carousel/custom_carousel.dart';

class HomeCarousel extends StatelessWidget {
  final List<Carousel> carousels;
  final Function(int value) onChanged;

  const HomeCarousel({
    super.key,
    required this.carousels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: carousels.length,
        itemBuilder: (context, index, idx) {
          return CustomCarousel(
            isNetWorkImage: false,
            carousel: carousels[index],
            onTap: () {},
          );
        },
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          autoPlay: true,
          enableInfiniteScroll: carousels.length > 1,
          onPageChanged: (index, reason) {
            onChanged(index);
          },
        ),
      ),
    );
  }
}
