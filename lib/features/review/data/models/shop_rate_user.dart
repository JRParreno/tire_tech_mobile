import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:tire_tech_mobile/features/review/data/models/shop_review.dart';

class ShopRateUser extends Equatable {
  final double rate;
  final ShopReview? userReview;
  final bool isOwner;
  final String shopName;

  const ShopRateUser({
    required this.rate,
    required this.shopName,
    this.userReview,
    this.isOwner = false,
  });

  ShopRateUser copyWith({
    double? rate,
    ShopReview? userReview,
    bool? isOwner,
    String? shopName,
  }) {
    return ShopRateUser(
      rate: rate ?? this.rate,
      userReview: userReview ?? this.userReview,
      isOwner: isOwner ?? this.isOwner,
      shopName: shopName ?? this.shopName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'rate': rate});
    if (userReview != null) {
      result.addAll({'userReview': userReview!.toMap()});
    }
    result.addAll({'isOwner': isOwner});

    return result;
  }

  @override
  List<Object?> get props => [rate, userReview, isOwner];

  factory ShopRateUser.fromMap(Map<String, dynamic> map) {
    return ShopRateUser(
      rate: map['rate']?.toDouble() ?? 0.0,
      userReview: map['user_review'] != null
          ? ShopReview.fromMap(map['user_review'])
          : null,
      isOwner: map['isOwner'] ?? false,
      shopName: map['shop_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopRateUser.fromJson(String source) =>
      ShopRateUser.fromMap(json.decode(source));
}
