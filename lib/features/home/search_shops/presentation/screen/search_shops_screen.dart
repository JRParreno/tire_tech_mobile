import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_appbar.dart';
import 'package:tire_tech_mobile/core/local_storage/local_storage.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_address.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_gallery_btn.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_header.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_information.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_list_draggable.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_open_close_time.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_rating_info.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/widget/shop_review_btn.dart';
import 'package:tire_tech_mobile/features/menu/presentation/screen/menu_screen.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class SearchShopsArgs {
  const SearchShopsArgs({
    required this.bitmapDescriptor,
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
  final BitmapDescriptor bitmapDescriptor;
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
  final GlobalKey<State<StatefulWidget>> _markerWalkThrough =
      GlobalKey(debugLabel: 'markerWalkThrough');
  final GlobalKey<State<StatefulWidget>> _shopsWalkThrough =
      GlobalKey(debugLabel: '_shopsWalkThrough');
  bool isMarkerWalkthrough = false;
  bool isShopsWalkThrough = false;
  bool isFirstWalkThrough = false;

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
      child: ShowCaseWidget(builder: Builder(
        builder: (ctx) {
          final showcase = ShowCaseWidget.of(ctx);

          if (!isFirstWalkThrough) {
            checkWalkThrough(showcase);
          }
          return Scaffold(
            appBar: buildAppBar(
              backgroundColor: Colors.transparent,
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
                        color: Colors.black,
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
                  final markers = shopToListMarker(
                    shops: state.shops,
                  );

                  final CameraPosition cameraPosition = state.shops.isNotEmpty
                      ? CameraPosition(
                          target: LatLng(state.shops.first.latitude,
                              state.shops.first.longitude),
                          zoom: 14.4746,
                        )
                      : _kGooglePlex;
                  return mapWidget(
                      showCase: showcase,
                      markers: markers,
                      cameraPosition: cameraPosition);
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
                  return Showcase(
                    targetPadding: const EdgeInsets.all(5),
                    key: _shopsWalkThrough,
                    onTargetClick: () {
                      setWalkThrough();
                    },
                    onBarrierClick: () {
                      setWalkThrough();
                    },
                    onToolTipClick: () {
                      setWalkThrough();
                    },
                    disposeOnTap: true,
                    description: "Tap here to see all the shops available.",
                    tooltipBackgroundColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    targetShapeBorder: const CircleBorder(),
                    child: FloatingActionButton(
                      onPressed: () =>
                          handleShowShopListBottomSheet(state.shops),
                      child: const Icon(Icons.store),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          );
        },
      )),
    );
  }

  Widget mapWidget({
    required List<Marker> markers,
    required CameraPosition cameraPosition,
    required ShowCaseWidgetState showCase,
  }) {
    return Stack(children: [
      GoogleMap(
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
      ),
      if (isMarkerWalkthrough && isShopsWalkThrough) ...[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Showcase(
                targetPadding: const EdgeInsets.all(5),
                key: _markerWalkThrough,
                onTargetClick: () {
                  closeFirstShowCase(showCase);
                },
                onBarrierClick: () {
                  closeFirstShowCase(showCase);
                },
                onToolTipClick: () {
                  closeFirstShowCase(showCase);
                },
                disposeOnTap: true,
                description: "Tap marker to select a shop",
                tooltipBackgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                targetShapeBorder: const CircleBorder(),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: const Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        )
      ]
    ]);
  }

  List<Marker> shopToListMarker({
    required List<Shop> shops,
  }) {
    List<Marker> markers = [];
    for (var shop in shops) {
      final tempMarker = Marker(
        icon: widget.args.bitmapDescriptor,
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
                            ShopRatingInfo(
                              rate: state.shopRateUser.rate,
                              totalReviews: state.shopReviews.length,
                            ),
                            ShopOpenCloseTime(
                              closeTime: shop.closeTime,
                              openTime: shop.openTime,
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

  Future<void> checkWalkThrough(ShowCaseWidgetState showcase) async {
    final isWalkThrough = await LocalStorage.readLocalStorage('_isWalkThrough');
    final value = isWalkThrough != null && isWalkThrough == 'true';

    setState(() {
      isMarkerWalkthrough = !value;
      isShopsWalkThrough = !value;
    });

    if (!value) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          isFirstWalkThrough = true;
        });
        showcase.startShowCase([_markerWalkThrough, _shopsWalkThrough]);
      });
    } else {
      isFirstWalkThrough = true;
    }
  }

  void setWalkThrough() {
    LocalStorage.storeLocalStorage('_isWalkThrough', 'true');
  }

  void closeFirstShowCase(ShowCaseWidgetState showCase) {
    setState(() {
      isMarkerWalkthrough = false;
    });
    showCase.startShowCase([_shopsWalkThrough]);
  }
}
