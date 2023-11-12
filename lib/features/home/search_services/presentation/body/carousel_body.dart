import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/home_carousel/home_carousel_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/carousel/home_carousel.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/carousel/home_carousel_list_scroll_indicators.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/carousel/home_carousel_loading.dart';

class CarouselBody extends StatelessWidget {
  const CarouselBody({
    super.key,
    required this.homeCarouselBloc,
    required this.handleOnChangedCarousel,
  });

  final HomeCarouselBloc homeCarouselBloc;
  final Function(int index) handleOnChangedCarousel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<HomeCarouselBloc, HomeCarouselState>(
        bloc: homeCarouselBloc,
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return Column(
              children: [
                HomeCarouselLoading(
                  onChanged: handleOnChangedCarousel,
                ),
                const SizedBox(
                  height: 15,
                ),
                const HomeCarouselListScrollIndicators(
                  carousels: [],
                  isLoading: true,
                  currentCarousel: 0,
                ),
              ],
            );
          }

          if (state is HomeCarouselLoaded) {
            return Column(
              children: [
                HomeCarousel(
                  carousels: state.carousels,
                  onChanged: handleOnChangedCarousel,
                ),
                const SizedBox(
                  height: 15,
                ),
                HomeCarouselListScrollIndicators(
                  carousels: state.carousels,
                  isLoading: false,
                  currentCarousel: state.index,
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
