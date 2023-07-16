part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class SearchShopEvent extends ShopEvent {
  const SearchShopEvent({
    required this.query,
  });

  final String query;

  @override
  List<Object> get props => [query];
}
