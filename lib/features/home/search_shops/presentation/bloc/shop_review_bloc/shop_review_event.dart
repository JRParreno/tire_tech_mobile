part of 'shop_review_bloc.dart';

class ShopReviewEvent extends Equatable {
  const ShopReviewEvent();

  @override
  List<Object> get props => [];
}

class GetShopReviewEvent extends ShopReviewEvent {
  const GetShopReviewEvent(this.pk);

  final String pk;

  @override
  List<Object> get props => [pk];
}

class GetShopReviewListEvent extends ShopReviewEvent {
  const GetShopReviewListEvent(this.pk);

  final String pk;

  @override
  List<Object> get props => [pk];
}

class GetShopReviewPaginateListEvent extends ShopReviewEvent {
  const GetShopReviewPaginateListEvent(this.pk);

  final String pk;

  @override
  List<Object> get props => [pk];
}
