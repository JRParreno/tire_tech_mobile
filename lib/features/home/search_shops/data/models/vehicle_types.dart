import 'dart:convert';

import 'package:equatable/equatable.dart';

class VehicleTypes extends Equatable {
  const VehicleTypes({
    required this.pk,
    required this.vehicleName,
  });

  final int pk;
  final String vehicleName;

  @override
  List<Object> get props => [
        pk,
        vehicleName,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'vehicleName': vehicleName});

    return result;
  }

  factory VehicleTypes.fromMap(Map<String, dynamic> map) {
    return VehicleTypes(
      pk: map['pk']?.toInt() ?? 0,
      vehicleName: map['vehicle_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleTypes.fromJson(String source) =>
      VehicleTypes.fromMap(json.decode(source));
}
