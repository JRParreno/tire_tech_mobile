import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceOffer extends Equatable {
  static ServiceOffer empty = const ServiceOffer(pk: '', serviceName: '');

  const ServiceOffer({
    required this.pk,
    required this.serviceName,
  });

  final String pk;
  final String serviceName;

  @override
  List<Object?> get props => [
        pk,
        serviceName,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'serviceName': serviceName});

    return result;
  }

  factory ServiceOffer.fromMap(Map<String, dynamic> map) {
    return ServiceOffer(
      pk: map['pk'] ?? '',
      serviceName: map['service-name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOffer.fromJson(String source) =>
      ServiceOffer.fromMap(json.decode(source));

  ServiceOffer copyWith({
    String? pk,
    String? serviceName,
  }) {
    return ServiceOffer(
      pk: pk ?? this.pk,
      serviceName: serviceName ?? this.serviceName,
    );
  }
}
