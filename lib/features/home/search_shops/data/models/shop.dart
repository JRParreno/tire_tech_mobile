import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop_category.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/vehicle_types.dart';

class Shop extends Equatable {
  const Shop({
    required this.pk,
    required this.shopName,
    required this.contactNumber,
    required this.openTime,
    required this.closeTime,
    required this.addressName,
    required this.longitude,
    required this.latitude,
    required this.shopPhotos,
    this.specialOffer,
    required this.shopCategory,
    required this.vehicleTypes,
  });

  final int pk;
  final String shopName;
  final String contactNumber;
  final String openTime;
  final String closeTime;
  final String addressName;
  final double longitude;
  final double latitude;
  final List<String> shopPhotos;
  final String? specialOffer;
  final List<ShopCategory> shopCategory;
  final List<VehicleTypes> vehicleTypes;

  @override
  List<Object?> get props {
    return [
      pk,
      shopName,
      contactNumber,
      openTime,
      closeTime,
      addressName,
      longitude,
      latitude,
      shopPhotos,
      specialOffer,
      shopCategory,
      vehicleTypes,
    ];
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'shopName': shopName});
    result.addAll({'contactNumber': contactNumber});
    result.addAll({'openTime': openTime});
    result.addAll({'closeTime': closeTime});
    result.addAll({'addressName': addressName});
    result.addAll({'longitude': longitude});
    result.addAll({'latitude': latitude});
    result.addAll({'shopPhotos': shopPhotos});
    if (specialOffer != null) {
      result.addAll({'specialOffer': specialOffer});
    }
    result
        .addAll({'shopCategory': shopCategory.map((x) => x.toMap()).toList()});
    result
        .addAll({'vehicleTypes': vehicleTypes.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      pk: map['pk']?.toInt() ?? 0,
      shopName: map['shop_name'] ?? '',
      contactNumber: map['contact_number'] ?? '',
      openTime: map['open_time'] ?? '',
      closeTime: map['close_time'] ?? '',
      addressName: map['address_name'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      shopPhotos: List<String>.from(map['shop_photos']),
      specialOffer: map['specialOffer'],
      shopCategory: List<ShopCategory>.from(
          map['shop_category']?.map((x) => ShopCategory.fromMap(x))),
      vehicleTypes: List<VehicleTypes>.from(
          map['vehicle_types']?.map((x) => VehicleTypes.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) => Shop.fromMap(json.decode(source));
}
