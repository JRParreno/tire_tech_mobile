import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopRateUser extends Equatable {
  final double rate;
  final String? commentId;

  const ShopRateUser({
    required this.rate,
    this.commentId,
  });

  ShopRateUser copyWith({
    double? rate,
    String? commentId,
  }) {
    return ShopRateUser(
      rate: rate ?? this.rate,
      commentId: commentId ?? this.commentId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'rate': rate});
    if (commentId != null) {
      result.addAll({'commentId': commentId});
    }

    return result;
  }

  factory ShopRateUser.fromMap(Map<String, dynamic> map) {
    return ShopRateUser(
      rate: map['rate']?.toDouble() ?? 0.0,
      commentId: map['comment_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopRateUser.fromJson(String source) =>
      ShopRateUser.fromMap(json.decode(source));

  @override
  String toString() => 'ShopRateUser(rate: $rate, commentId: $commentId)';

  @override
  List<Object?> get props => [rate, commentId];
}
