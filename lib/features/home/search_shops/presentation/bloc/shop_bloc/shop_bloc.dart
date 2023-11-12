import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_event.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/repositories/search_shops_repository_impl.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';
import 'dart:ui' as ui;

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(const InitialState()) {
    on<InitialEvent>(_initialEvent);
    on<SearchShopEvent>(_searchShops);
  }

  void _initialEvent(InitialEvent event, Emitter<ShopState> emit) {
    return emit(const InitialState());
  }

  Future<void> _searchShops(
      SearchShopEvent event, Emitter<ShopState> emit) async {
    final categoryQuery = event.categoryQuery;
    final serviceQuery = event.serviceQuery;

    final Uint8List markerIcon = await getBytesFromAsset(
        Assets.icons.shopIcons.outputOnlinepngtools.path, 100);

    final iconMarker = BitmapDescriptor.fromBytes(markerIcon);

    emit(const LoadingState());

    if (categoryQuery != null) {
      try {
        final shops = await SearchShopsRepositoryImpl().searchShop(
          query: categoryQuery,
          latitude: event.latitude,
          longitude: event.longitude,
        );
        return emit(ShopLoaded(
          shops: shops,
          iconMarker: iconMarker,
        ));
      } catch (err) {
        return emit(ErrorState(err.toString()));
      }
    }

    if (serviceQuery != null) {
      try {
        final shops = await SearchShopsRepositoryImpl().searchShopByService(
          query: serviceQuery,
          latitude: event.latitude,
          longitude: event.longitude,
        );
        return emit(ShopLoaded(shops: shops, iconMarker: iconMarker));
      } catch (err) {
        return emit(ErrorState(err.toString()));
      }
    }

    emit(const InitialState());
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
