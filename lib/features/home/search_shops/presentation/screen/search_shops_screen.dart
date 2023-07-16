import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_bloc.dart';

class SearchShopsArgs {
  const SearchShopsArgs({
    required this.query,
  });

  final String query;
}

class SearchShopsScreen extends StatefulWidget {
  static const String routeName = 'search-shops';

  const SearchShopsScreen({super.key, required this.args});

  final SearchShopsArgs args;

  @override
  State<SearchShopsScreen> createState() => _SearchShopsScreenState();
}

class _SearchShopsScreenState extends State<SearchShopsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.169636, 123.4875681),
    zoom: 14.4746,
  );

  List<Marker> markers = [
    const Marker(
      markerId: MarkerId('sample1'),
      position: LatLng(13.169636, 123.4875681),
      infoWindow: InfoWindow(
        title: 'sample 1',
        snippet: 'sample 1 address',
      ),
    ),
    const Marker(
      markerId: MarkerId('sample2'),
      position: LatLng(13.1716, 123.4916991),
      infoWindow: InfoWindow(
        title: 'sample 2',
        snippet: 'sample 2 address',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopBloc()..add(SearchShopEvent(query: widget.args.query)),
      child: Scaffold(
        body: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ShopLoaded) {
              final markers = shopToListMarker(state.shops);

              final CameraPosition cameraPosition = state.shops.isNotEmpty
                  ? CameraPosition(
                      target: LatLng(state.shops.first.latitude,
                          state.shops.first.longitude),
                      zoom: 14.4746,
                    )
                  : _kGooglePlex;
              return mapWidget(
                  markers: markers, cameraPosition: cameraPosition);
            }

            // Error exception
            return const Center(
              child: CustomText(text: 'Please try again'),
            );
          },
        ),
      ),
    );
  }

  Widget mapWidget({
    required List<Marker> markers,
    required CameraPosition cameraPosition,
  }) {
    return GoogleMap(
      mapType: MapType.normal,
      buildingsEnabled: false,
      onTap: (argument) {},
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers.toSet(),
      mapToolbarEnabled: false,
    );
  }

  List<Marker> shopToListMarker(List<Shop> shops) {
    List<Marker> markers = [];

    for (var shop in shops) {
      final tempMarker = Marker(
        markerId: MarkerId(shop.pk.toString()),
        position: LatLng(shop.latitude, shop.longitude),
        infoWindow: InfoWindow(
          title: shop.shopName,
          snippet: shop.addressName,
        ),
      );
      markers.add(tempMarker);
    }

    return markers;
  }
}
