import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';

class ShopReviewListResponse {
  final List<ShopReview> shopReviews;
  final int count;
  final bool hasNextPage;

  ShopReviewListResponse({
    required this.shopReviews,
    required this.count,
    required this.hasNextPage,
  });

  ShopReviewListResponse copyWith({
    List<ShopReview>? shopReviews,
    int? count,
    bool? hasNextPage,
  }) {
    return ShopReviewListResponse(
      shopReviews: shopReviews ?? this.shopReviews,
      count: count ?? this.count,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'shopReviews': shopReviews.map((x) => x.toMap()).toList()});
    result.addAll({'count': count});
    result.addAll({'hasNextPage': hasNextPage});

    return result;
  }

  factory ShopReviewListResponse.fromMap(Map<String, dynamic> map) {
    return ShopReviewListResponse(
      shopReviews: List<ShopReview>.from(
          map['shopReviews']?.map((x) => ShopReview.fromMap(x))),
      count: map['count']?.toInt() ?? 0,
      hasNextPage: map['hasNextPage'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopReviewListResponse.fromJson(String source) =>
      ShopReviewListResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ShopReviewListResponse(shopReviews: $shopReviews, count: $count, hasNextPage: $hasNextPage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopReviewListResponse &&
        listEquals(other.shopReviews, shopReviews) &&
        other.count == count &&
        other.hasNextPage == hasNextPage;
  }

  @override
  int get hashCode =>
      shopReviews.hashCode ^ count.hashCode ^ hasNextPage.hashCode;
}
