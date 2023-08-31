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
    this.latitude = 0,
    this.longitude = 0,
  });

  final String? categoryQuery;
  final String? serviceQuery;
  final double longitude;
  final double latitude;
  @override
  List<Object?> get props => [
        categoryQuery,
        serviceQuery,
        longitude,
        latitude,
      ];
}
