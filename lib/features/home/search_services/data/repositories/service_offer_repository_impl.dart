import 'package:dio/dio.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/core/interceptor/api_interceptor.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/models/service_offer.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/service_offer_repository.dart';

class ServiceOffRepositoryImpl extends ServiceOfferRepository {
  final Dio dio = Dio();

  @override
  Future<List<ServiceOffer>> getServiceList() async {
    String url = '${AppConstant.serverUrl}/api/services-offer';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final data = results.map((e) => ServiceOffer.fromMap(e)).toList();
        return data;
      }
      return [] as List<ServiceOffer>;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
