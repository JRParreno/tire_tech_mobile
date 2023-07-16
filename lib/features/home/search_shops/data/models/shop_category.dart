import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopCategory extends Equatable {
  const ShopCategory({
    required this.pk,
    required this.categoryName,
  });

  final int pk;
  final String categoryName;

  @override
  List<Object?> get props => [
        pk,
        categoryName,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'categoryName': categoryName});

    return result;
  }

  factory ShopCategory.fromMap(Map<String, dynamic> map) {
    return ShopCategory(
      pk: map['pk'] ?? '',
      categoryName: map['category_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopCategory.fromJson(String source) =>
      ShopCategory.fromMap(json.decode(source));
}
