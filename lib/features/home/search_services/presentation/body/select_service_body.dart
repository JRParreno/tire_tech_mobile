import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/core/common_widget/common_widget.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';

class SelectServiceBody extends StatelessWidget {
  const SelectServiceBody({
    super.key,
    required this.services,
    required this.handleSearchService,
  });

  final List<ServiceOffer> services;

  final Function(ServiceOffer serviceOffer) handleSearchService;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: services.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final serviceOffer = services[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CustomBtn(
            onTap: () {
              handleSearchService(
                serviceOffer,
              );
            },
            label: serviceOffer.serviceName,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            radius: 15,
            alignment: Alignment.centerLeft,
          ),
        );
      },
    );
  }
}
