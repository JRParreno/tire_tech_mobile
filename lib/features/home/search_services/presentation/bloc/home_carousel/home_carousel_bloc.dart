import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/carousel.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/carousel/carousel_repository.dart';

part 'home_carousel_event.dart';
part 'home_carousel_state.dart';

class HomeCarouselBloc extends Bloc<HomeCarouselEvent, HomeCarouselState> {
  final CarouselRepository _carouselRepository;

  HomeCarouselBloc(this._carouselRepository) : super(const InitialState()) {
    on<GetHomeCarouselEvent>(_onGetHomeCarouselEvent);
    on<OnChangedCarousel>(_onChangedCarousel);
  }

  FutureOr<void> _onGetHomeCarouselEvent(
      GetHomeCarouselEvent event, Emitter<HomeCarouselState> emit) async {
    emit(const LoadingState());

    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        final carousels = await _carouselRepository.fetchCarousel();
        emit(HomeCarouselLoaded(carousels: carousels));
      });
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  FutureOr<void> _onChangedCarousel(
      OnChangedCarousel event, Emitter<HomeCarouselState> emit) async {
    final state = this.state;

    if (state is HomeCarouselLoaded) {
      emit(state.copyWith(index: event.index));
    }
  }
}
