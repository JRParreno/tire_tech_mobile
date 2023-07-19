import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopService extends Equatable {
  const ShopService({
    required this.pk,
    required this.serviceName,
  });

  final int pk;
  final String serviceName;

  @override
  List<Object> get props => [pk, serviceName];

  ShopService copyWith({
    int? pk,
    String? serviceName,
  }) {
    return ShopService(
      pk: pk ?? this.pk,
      serviceName: serviceName ?? this.serviceName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'serviceName': serviceName});

    return result;
  }

  factory ShopService.fromMap(Map<String, dynamic> map) {
    return ShopService(
      pk: map['pk']?.toInt() ?? 0,
      serviceName: map['service_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopService.fromJson(String source) =>
      ShopService.fromMap(json.decode(source));
}
