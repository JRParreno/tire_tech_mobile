import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_address.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_gallery_btn.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_header.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_information.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_list_draggable.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_review_btn.dart';
import 'package:tire_tech_mobile/features/menu/presentation/screen/menu_screen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class SearchShopsArgs {
  const SearchShopsArgs({
    this.categoryQuery,
    this.serviceQuery,
    this.serviceName,
    this.longitude = 0,
    this.latitude = 0,
  });

  final String? categoryQuery;
  final String? serviceQuery;
  final String? serviceName;
  final double longitude;
  final double latitude;
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
  late ShopReviewBloc shopReviewBloc;

  @override
  void initState() {
    shopReviewBloc = BlocProvider.of<ShopReviewBloc>(context);
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
            latitude: widget.args.latitude,
            longitude: widget.args.longitude,
          ),
        ),
      child: Scaffold(
        appBar: buildAppBar(
          backgroundColor: ColorName.primary.withOpacity(.50),
          context: context,
          titleWidget: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(
                  Icons.search,
                  color: ColorName.primary,
                ),
              ),
            ),
          ),
          showBackBtn: true,
          actions: [
            GestureDetector(
              onTap: handleNavigateMenu,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.menu,
                    color: ColorName.primary,
                  ),
                ),
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
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
        onTap: () => handleShowShopBottomSheet(shop),
      );
      markers.add(tempMarker);
    }

    return markers;
  }

  void handleShowShopBottomSheet(Shop shop) {
    shopReviewBloc.add(GetShopReviewEvent(shop.pk.toString()));

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: DraggableScrollableSheet(
            initialChildSize: .35,
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 100),
                  padding: MediaQuery.of(context).viewInsets,
                  child: BlocBuilder<ShopReviewBloc, ShopReviewState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is ShopReviewLoaded) {
                        return Column(
                          children: [
                            Visibility(
                              child: Container(
                                height: 4,
                                width: 32,
                                margin: const EdgeInsets.only(top: 15),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                              ),
                            ),
                            ShopHeader(
                              shop: shop,
                              rate: state.shopRateUser.rate,
                            ),
                            ShopAddress(shop: shop),
                            ShopInformation(shop: shop),
                            ShopReviewBtn(
                              pk: shop.pk.toString(),
                              shopRateUser: state.shopRateUser,
                            ),
                            if (shop.shopPhotos.isNotEmpty) ...[
                              ShopGalleryBtn(
                                shopName: shop.shopName,
                                photoUrls: shop.shopPhotos,
                              )
                            ]
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void handleShowShopListBottomSheet(List<Shop> shops) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: ShopListDraggable(
            title: widget.args.categoryQuery != null
                ? widget.args.categoryQuery!
                : widget.args.serviceName!,
            shops: shops,
            onTap: (shop) => handleOpenShopModal(shop: shop, shops: shops),
          ),
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
      handleShowShopBottomSheet(shop);
    });
  }

  void handleNavigateMenu() {
    Navigator.of(context).pushNamed(MenuScreen.routeName);
  }
}
