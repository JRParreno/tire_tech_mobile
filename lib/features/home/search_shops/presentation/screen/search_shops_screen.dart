import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_address.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_header.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_information.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_list_draggable.dart';

class SearchShopsArgs {
  const SearchShopsArgs({
    this.categoryQuery,
    this.serviceQuery,
    this.serviceName,
  });

  final String? categoryQuery;
  final String? serviceQuery;
  final String? serviceName;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc()
        ..add(
          SearchShopEvent(
            categoryQuery: widget.args.categoryQuery,
            serviceQuery: widget.args.serviceQuery,
          ),
        ),
      child: Scaffold(
        appBar: buildAppBar(context: context),
        body: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ShopLoaded) {
              final markers = shopToListMarker(state.shops);

              Future.delayed(const Duration(seconds: 1), () {
                handleShowShopListBottomSheet(state.shops);
              });

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
        floatingActionButton: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is ShopLoaded) {
              return FloatingActionButton(
                onPressed: () => handleShowShopListBottomSheet(state.shops),
                child: const Icon(Icons.store),
              );
            }

            return const SizedBox();
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
      compassEnabled: false,
      zoomControlsEnabled: false,
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
        onTap: () => handleShowShopBottomSheet(shop: shop, shops: shops),
      );
      markers.add(tempMarker);
    }

    return markers;
  }

  void handleShowShopBottomSheet({
    required Shop shop,
    required List<Shop> shops,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            color: Color(0xFF2E2E2E),
            borderRadius:
                BorderRadius.only(topRight: Radius.elliptical(80, 60)),
          ),
          child: Column(
            children: [
              ShopHeader(shop: shop),
              ShopAddress(shop: shop),
              ShopInformation(shop: shop),
            ],
          ),
        );
      },
    );
  }

  void handleShowShopListBottomSheet(List<Shop> shops) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      isDismissible: false,
      builder: (BuildContext context) {
        return ShopListDraggable(
          title: widget.args.categoryQuery != null
              ? widget.args.categoryQuery!
              : widget.args.serviceName!,
          shops: shops,
          onTap: (shop) => handleOpenShopModal(shop: shop, shops: shops),
        );
      },
    );
  }

  void handleOpenShopModal({
    required Shop shop,
    required List<Shop> shops,
  }) {
    Navigator.of(context).pop();

    Future.delayed(const Duration(milliseconds: 500), () {
      handleShowShopBottomSheet(shop: shop, shops: shops);
    });
  }
}
