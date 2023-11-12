part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

class ShopLoaded extends ShopState {
  final List<Shop> shops;
  final BitmapDescriptor iconMarker;

  const ShopLoaded({
    required this.shops,
    required this.iconMarker,
  });

  @override
  List<Object?> get props => [
        shops,
        iconMarker,
      ];
}
