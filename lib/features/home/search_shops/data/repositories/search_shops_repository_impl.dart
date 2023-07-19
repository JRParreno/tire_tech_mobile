import 'package:dio/dio.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/core/interceptor/api_interceptor.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/repositories/search_shops_repository.dart';

class SearchShopsRepositoryImpl extends SearchShopsRepository {
  final Dio dio = Dio();

  @override
  Future<List<Shop>> searchShop(String query) async {
    String url = '${AppConstant.serverUrl}/api/find-shop?search_query=$query';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;
      final List<Shop> shops = [];

      if (results.isNotEmpty) {
        final data = results.map((e) => Shop.fromMap(e)).toList();
        return data;
      }
      return shops;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<List<Shop>> searchShopByService(String query) async {
    String url = '${AppConstant.serverUrl}/api/find-shop?service_pk=$query';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;
      final List<Shop> shops = [];

      if (results.isNotEmpty) {
        final data = results.map((e) => Shop.fromMap(e)).toList();
        return data;
      }
      return shops;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
