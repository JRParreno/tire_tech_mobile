import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopReview extends Equatable {
  final String description;
  final int rate;

  const ShopReview({
    required this.description,
    required this.rate,
  });

  @override
  List<Object> get props => [description, rate];

  ShopReview copyWith({
    String? description,
    int? rate,
  }) {
    return ShopReview(
      description: description ?? this.description,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'description': description});
    result.addAll({'rate': rate});

    return result;
  }

  factory ShopReview.fromMap(Map<String, dynamic> map) {
    return ShopReview(
      description: map['description'] ?? '',
      rate: map['rate']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopReview.fromJson(String source) =>
      ShopReview.fromMap(json.decode(source));
}
