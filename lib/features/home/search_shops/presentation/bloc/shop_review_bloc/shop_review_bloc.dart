import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/repository/shop_review_repository.dart';

part 'shop_review_event.dart';
part 'shop_review_state.dart';

class ShopReviewBloc extends Bloc<ShopReviewEvent, ShopReviewState> {
  final ShopReviewRepository _shopReviewRepository;

  ShopReviewBloc(this._shopReviewRepository) : super(const InitialState()) {
    on<GetShopReviewEvent>(_onGetShopReviewEvent);
  }

  FutureOr<void> _onGetShopReviewEvent(
      GetShopReviewEvent event, Emitter<ShopReviewState> emit) async {
    emit(const LoadingState());

    try {
      final response =
          await _shopReviewRepository.fetchTotalRateShopReview(event.pk);
      return emit(ShopReviewLoaded(response));
    } catch (err) {
      return emit(ErrorState(err.toString()));
    }
  }
}
