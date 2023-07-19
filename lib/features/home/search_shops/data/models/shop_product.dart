import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopProduct extends Equatable {
  const ShopProduct({
    required this.pk,
    required this.productName,
  });

  final int pk;
  final String productName;

  @override
  List<Object> get props => [pk, productName];

  ShopProduct copyWith({
    int? pk,
    String? productName,
  }) {
    return ShopProduct(
      pk: pk ?? this.pk,
      productName: productName ?? this.productName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'productName': productName});

    return result;
  }

  factory ShopProduct.fromMap(Map<String, dynamic> map) {
    return ShopProduct(
      pk: map['pk']?.toInt() ?? 0,
      productName: map['product_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopProduct.fromJson(String source) =>
      ShopProduct.fromMap(json.decode(source));
}
