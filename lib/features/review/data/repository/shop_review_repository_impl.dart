import 'package:dio/dio.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/core/interceptor/api_interceptor.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_rate_user.dart';
import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';
import 'package:tire_tech_mobile/features/review/data/repository/shop_review_repository.dart';

class ShopReviewRepositoryImpl implements ShopReviewRepository {
  static Dio dio = Dio();

  @override
  Future<ShopReview> addShopReview(
      {required String pk,
      required String description,
      required int rate}) async {
    // TODO: implement fetchShopReviewList
    throw UnimplementedError();
  }

  @override
  Future<List<ShopReview>> fetchShopReviewList(String pk) async {
    final String url = '${AppConstant.apiUrl}/shop-review-list/$pk';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;
      List<ShopReview> shops = [];

      if (results.isNotEmpty) {
        shops = results.map((e) => ShopReview.fromMap(e)).toList();
      }
      return shops;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<ShopRateUser> fetchTotalRateShopReview(String pk) {
    final String url = '${AppConstant.apiUrl}/shop-review-total-rate/$pk';

    return ApiInterceptor.apiInstance().get(url).then((value) {
      final response = ShopRateUser.fromMap(value.data);

      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
