import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/service_offer_repository_impl.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/search_bar_widget.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop_service.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(10),
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
                        child: const Center(
                          child: Icon(Icons.person),
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                                backgroundColor: const Color(0x008F8E8E),
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

  void handleSearch() {
    Navigator.of(context).pushNamed(
      SearchShopsScreen.routeName,
      arguments: SearchShopsArgs(categoryQuery: queryCtrl.text),
    );
  }

  void handleSearchService(ServiceOffer serviceOffer) {
    Navigator.of(context).pushNamed(
      SearchShopsScreen.routeName,
      arguments: SearchShopsArgs(
          serviceQuery: serviceOffer.pk.toString(),
          serviceName: serviceOffer.serviceName),
    );
  }
}
