import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopReview extends Equatable {
  final String description;
  final int rate;
  final String fullName;

  const ShopReview({
    required this.description,
    required this.rate,
    required this.fullName,
  });

  @override
  List<Object> get props => [description, rate, fullName];

  ShopReview copyWith({
    String? description,
    int? rate,
    String? fullName,
  }) {
    return ShopReview(
      description: description ?? this.description,
      rate: rate ?? this.rate,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'description': description});
    result.addAll({'rate': rate});
    result.addAll({'fullName': fullName});

    return result;
  }

  factory ShopReview.fromMap(Map<String, dynamic> map) {
    return ShopReview(
      description: map['description'] ?? '',
      rate: map['rate']?.toInt() ?? 0,
      fullName: map['user_profile']['user']['get_full_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopReview.fromJson(String source) =>
      ShopReview.fromMap(json.decode(source));

  @override
  String toString() =>
      'ShopReview(description: $description, rate: $rate, fullName: $fullName)';
}
