import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';
import 'package:tire_tech_mobile/features/review/data/repository/shop_review_repository.dart';

part 'shop_review_event.dart';
part 'shop_review_state.dart';

class ShopReviewBloc extends Bloc<ShopReviewEvent, ShopReviewState> {
  final ShopReviewRepository _shopReviewRepository;

  ShopReviewBloc(this._shopReviewRepository) : super(const InitialState()) {
    on<GetShopReviewEvent>(_onGetShopReviewEvent);
    on<GetShopReviewListEvent>(_onGetShopReviewListEvent);
    on<GetShopReviewPaginateListEvent>(_onGetShopReviewPaginateListEvent);
  }

  FutureOr<void> _onGetShopReviewEvent(
      GetShopReviewEvent event, Emitter<ShopReviewState> emit) async {
    emit(const LoadingState());

    try {
      final response =
          await _shopReviewRepository.fetchTotalRateShopReview(event.pk);
      return emit(
        ShopReviewLoaded(
          shopRateUser: response,
        ),
      );
    } catch (err) {
      return emit(ErrorState(err.toString()));
    }
  }

  FutureOr<void> _onGetShopReviewListEvent(
      GetShopReviewListEvent event, Emitter<ShopReviewState> emit) async {
    final state = this.state;

    if (state is ShopReviewLoaded) {
      emit(const LoadingState());

      try {
        final response = await _shopReviewRepository.fetchShopReviewList(
          pk: event.pk,
          page: state.page,
        );
        return emit(
          ShopReviewLoaded(
            shopRateUser: state.shopRateUser,
            shopReviews: response.shopReviews,
            hasNext: response.hasNextPage,
            count: response.count,
          ),
        );
      } catch (err) {
        return emit(ErrorState(err.toString()));
      }
    }
  }

  FutureOr<void> _onGetShopReviewPaginateListEvent(
      GetShopReviewPaginateListEvent event,
      Emitter<ShopReviewState> emit) async {
    final state = this.state;

    if (state is ShopReviewLoaded) {
      if (state.hasNext) {
        emit(
          ShopReviewLoaded(
            shopRateUser: state.shopRateUser,
            shopReviews: state.shopReviews,
            isPaginate: true,
          ),
        );

        try {
          final int page = state.page + 1;
          final response = await _shopReviewRepository.fetchShopReviewList(
            pk: event.pk,
            page: page,
          );

          return emit(
            ShopReviewLoaded(
              shopRateUser: state.shopRateUser,
              shopReviews: response.shopReviews.isNotEmpty
                  ? [...state.shopReviews, ...response.shopReviews]
                  : state.shopReviews,
              isPaginate: false,
              page: response.hasNextPage ? page : state.page,
              hasNext: response.hasNextPage,
              count: response.count,
            ),
          );
        } catch (err) {
          return emit(ErrorState(err.toString()));
        }
      }
    }
  }
}
