import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/widget/search_bar_widget.dart';

class SearchServicesScreen extends StatefulWidget {
  static const String routeName = 'home/search-services';

  const SearchServicesScreen({super.key});

  @override
  State<SearchServicesScreen> createState() => _SearchServicesScreenState();
}

class _SearchServicesScreenState extends State<SearchServicesScreen> {
  final TextEditingController queryCtrl = TextEditingController();

  final List<ServiceOffer> services = [
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
  ];

  List<ServiceOffer> filterServices = [
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
    const ServiceOffer(pk: '1', serviceName: 'Automotive'),
    const ServiceOffer(pk: '2', serviceName: 'Tune up'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filterServices.length,
                      itemBuilder: (context, index) {
                        final serviceOffer = filterServices[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomBtn(
                            label: serviceOffer.serviceName,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleSearch() {
    setState(() {
      filterServices = services
          .where((element) => element.serviceName
              .toLowerCase()
              .contains(queryCtrl.value.text.toLowerCase()))
          .toList();
    });
  }
}
