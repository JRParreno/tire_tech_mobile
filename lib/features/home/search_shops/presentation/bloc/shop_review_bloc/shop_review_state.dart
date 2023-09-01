part of 'shop_review_bloc.dart';

class ShopReviewState extends Equatable {
  const ShopReviewState();

  @override
  List<Object?> get props => [];
}

class ShopReviewLoaded extends ShopReviewState {
  const ShopReviewLoaded(this.shopRateUser);

  final ShopRateUser shopRateUser;

  @override
  List<Object?> get props => [shopRateUser];
}
