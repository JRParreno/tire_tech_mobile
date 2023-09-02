part of 'shop_review_bloc.dart';

class ShopReviewState extends Equatable {
  const ShopReviewState();

  @override
  List<Object?> get props => [];
}

class ShopReviewLoaded extends ShopReviewState {
  const ShopReviewLoaded({
    required this.shopRateUser,
    this.shopReviews = const [],
    this.page = 1,
    this.isPaginate = false,
    this.hasNext = false,
    this.count = 0,
  });

  final ShopRateUser shopRateUser;
  final List<ShopReview> shopReviews;
  final int page;
  final bool isPaginate;
  final bool hasNext;
  final int count;

  @override
  List<Object?> get props => [
        shopRateUser,
        shopReviews,
        page,
        isPaginate,
        hasNext,
        count,
      ];
}
