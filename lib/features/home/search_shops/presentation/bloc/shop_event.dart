part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

class SearchShopEvent extends ShopEvent {
  const SearchShopEvent({
    this.categoryQuery,
    this.serviceQuery,
  });

  final String? categoryQuery;
  final String? serviceQuery;
  @override
  List<Object?> get props => [categoryQuery, serviceQuery];
}
