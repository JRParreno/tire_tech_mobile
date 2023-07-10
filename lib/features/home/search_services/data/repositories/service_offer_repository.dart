import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';

abstract class ServiceOfferRepository {
  Future<List<ServiceOffer>> getServiceList();
}
