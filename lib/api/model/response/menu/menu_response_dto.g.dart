// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuResponseDto _$MenuResponseDtoFromJson(Map<String, dynamic> json) =>
    MenuResponseDto(
      itemID: (json['itemID'] as num?)?.toInt(),
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPrice: (json['itemPrice'] as num?)?.toDouble(),
      restaurantName: json['restaurantName'] as String?,
      restaurantID: (json['restaurantID'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$MenuResponseDtoToJson(MenuResponseDto instance) =>
    <String, dynamic>{
      'itemID': instance.itemID,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'itemPrice': instance.itemPrice,
      'restaurantName': instance.restaurantName,
      'restaurantID': instance.restaurantID,
      'imageUrl': instance.imageUrl,
    };
