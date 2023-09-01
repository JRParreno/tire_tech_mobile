import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';

abstract class ShopReviewRepository {
  Future<List<ShopReview>> fetchShopReviewList(String pk);
  Future<ShopRateUser> fetchTotalRateShopReview(String pk);
  Future<ShopReview> addShopReview({
    required String pk,
    required String description,
    required int rate,
  });
}
