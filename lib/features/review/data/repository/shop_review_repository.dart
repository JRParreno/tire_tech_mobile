import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review_list_response.dart';

abstract class ShopReviewRepository {
  Future<ShopReviewListResponse> fetchShopReviewList({
    required String pk,
    required int page,
  });
  Future<ShopRateUser> fetchTotalRateShopReview(String pk);
  Future<ShopReview> addShopReview({
    required String pk,
    required String description,
    required int rate,
  });
}
