// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDto _$RestaurantDtoFromJson(Map<String, dynamic> json) =>
    RestaurantDto(
      restaurantID: (json['restaurantID'] as num?)?.toInt(),
      restaurantName: json['restaurantName'] as String?,
      address: json['address'] as String?,
      type: json['type'] as String?,
      parkingLot: json['parkingLot'] as bool?,
    );

Map<String, dynamic> _$RestaurantDtoToJson(RestaurantDto instance) =>
    <String, dynamic>{
      'restaurantID': instance.restaurantID,
      'restaurantName': instance.restaurantName,
      'address': instance.address,
      'type': instance.type,
      'parkingLot': instance.parkingLot,
    };
