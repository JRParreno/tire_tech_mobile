import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/location/get_current_location.dart';
import 'package:tire_tech_mobile/core/permission/app_permission.dart';
import 'package:tire_tech_mobile/core/utils/spacing/v_space.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/service_offer_repository_impl.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/home_carousel/home_carousel_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/body/carousel_body.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/body/select_service_body.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/body/services_app_bar.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/screen/search_shops_screen.dart';

class ServicesScreen extends StatefulWidget {
  static const String routeName = 'home/services';

  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController queryCtrl = TextEditingController();
  late final HomeCarouselBloc homeCarouselBloc;

  List<ServiceOffer>? services;

  List<ServiceOffer>? filterServices;

  @override
  void initState() {
    handleGetServicesOffer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ServicesAppBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselBody(
                        homeCarouselBloc: homeCarouselBloc,
                        handleOnChangedCarousel: handleOnChangedCarousel,
                      ),
                      Vspace.md,
                      const CustomText(
                        text: "Select Preferred Service",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Vspace.sm,
                      if (services != null && filterServices != null) ...[
                        SelectServiceBody(
                          handleSearchService: (value) {
                            handleSearchService(value);
                          },
                          services: filterServices!,
                        ),
                      ] else ...[
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleOnChangedCarousel(int index) {
    homeCarouselBloc.add(OnChangedCarousel(index));
  }

  Future<void> handleGetServicesOffer() async {
    homeCarouselBloc = BlocProvider.of<HomeCarouselBloc>(context);

    homeCarouselBloc.add(GetHomeCarouselEvent());

    final tempList = await ServiceOffRepositoryImpl().getServiceList();
    setState(() {
      services = tempList;
      filterServices = tempList;
    });
  }

  Future<void> handleSearchService(ServiceOffer serviceOffer) async {
    final locationPermGranted = await AppPermission.locationPermission();

    if (locationPermGranted) {
      EasyLoading.show();

      final currentLocation = await getCurrentLocation();

      EasyLoading.dismiss();

      Future.delayed(const Duration(milliseconds: 500), () {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(
          SearchShopsScreen.routeName,
          arguments: SearchShopsArgs(
            serviceQuery: serviceOffer.pk.toString(),
            serviceName: serviceOffer.serviceName,
            latitude: currentLocation?.latitude ?? 0,
            longitude: currentLocation?.longitude ?? 0,
          ),
        );
      });
    } else {
      AppSettings.openAppSettings();
    }
  }
}
