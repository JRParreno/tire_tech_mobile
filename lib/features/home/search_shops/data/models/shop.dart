import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop_category.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop_product.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop_service.dart';
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
    required this.products,
    required this.services,
    this.productDescription,
    this.serviceDescription,
    this.walkinProductDescription,
    this.walkinServiceDescription,
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
  final String? serviceDescription;
  final String? walkinServiceDescription;
  final List<ShopService> services;
  final String? productDescription;
  final String? walkinProductDescription;
  final List<ShopProduct> products;

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
      serviceDescription,
      walkinServiceDescription,
      services,
      productDescription,
      walkinProductDescription,
      products,
    ];
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
      products: List<ShopProduct>.from(
          map['products']?.map((x) => ShopProduct.fromMap(x))),
      services: List<ShopService>.from(
          map['services']?.map((x) => ShopService.fromMap(x))),
      serviceDescription: map['service_description'] ?? '',
      walkinServiceDescription: map['walk_in_service_description'] ?? '',
      productDescription: map['product_description'] ?? '',
      walkinProductDescription: map['walk_in_product_description'] ?? '',
    );
  }

  factory Shop.fromJson(String source) => Shop.fromMap(json.decode(source));
}
