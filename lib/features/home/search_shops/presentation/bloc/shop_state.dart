part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

class ShopLoaded extends ShopState {
  final List<Shop> shops;

  const ShopLoaded({
    required this.shops,
  });

  @override
  List<Object?> get props => [shops];
}
