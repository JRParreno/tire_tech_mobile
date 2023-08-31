import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';

abstract class SearchShopsRepository {
  Future<List<Shop>> searchShop({
    required String query,
    required double longitude,
    required double latitude,
  });
  Future<List<Shop>> searchShopByService({
    required String query,
    required double longitude,
    required double latitude,
  });
}
