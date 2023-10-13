import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/core/location/get_current_location.dart';
import 'package:tire_tech_mobile/core/permission/app_permission.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/service_offer_repository_impl.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/search_bar_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/screen/search_shops_screen.dart';

class SearchServicesScreen extends StatefulWidget {
  static const String routeName = 'home/search-services';

  const SearchServicesScreen({super.key});

  @override
  State<SearchServicesScreen> createState() => _SearchServicesScreenState();
}

class _SearchServicesScreenState extends State<SearchServicesScreen> {
  final TextEditingController queryCtrl = TextEditingController();

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
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: const Alignment(1, 1),
                  colors: <Color>[
                    const Color(0xff38b6ff).withOpacity(1),
                    const Color(0xff38b6ff).withOpacity(0.25),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName),
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is ProfileLoaded) {
                                  return CircleAvatar(
                                    backgroundImage:
                                        state.profile?.profilePhoto != null
                                            ? NetworkImage(
                                                state.profile!.profilePhoto!,
                                                scale: 50,
                                              )
                                            : null,
                                    radius: 25,
                                    child: state.profile?.profilePhoto != null
                                        ? null
                                        : const Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                  );
                                }

                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SearchBarWidget(
                          onSearch: handleSearch,
                          placeholder: "Search service",
                          query: queryCtrl.text,
                          controller: queryCtrl,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Select Preferred",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomText(
                          text: "Service",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (services != null && filterServices != null) ...[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filterServices!.length,
                          itemBuilder: (context, index) {
                            final serviceOffer = filterServices![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CustomBtn(
                                onTap: () => handleSearchService(
                                  serviceOffer,
                                ),
                                label: serviceOffer.serviceName,
                                backgroundColor: Colors.white,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
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
          ),
        ),
      ),
    );
  }

  Future<void> handleGetServicesOffer() async {
    final tempList = await ServiceOffRepositoryImpl().getServiceList();
    setState(() {
      services = tempList;
      filterServices = tempList;
    });
  }

  Future<void> handleSearch() async {
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
            categoryQuery: queryCtrl.text,
            latitude: currentLocation?.latitude ?? 0,
            longitude: currentLocation?.longitude ?? 0,
          ),
        );
      });
    } else {
      AppSettings.openAppSettings();
    }
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
