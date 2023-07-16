import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';

abstract class SearchShopsRepository {
  Future<List<Shop>> searchShop(String query);
}
