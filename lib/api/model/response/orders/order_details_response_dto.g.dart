// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsResponseDto _$OrderDetailsResponseDtoFromJson(
  Map<String, dynamic> json,
) => OrderDetailsResponseDto(
  orderID: (json['orderID'] as num?)?.toInt(),
  user: json['user'] == null
      ? null
      : UserResponseDto.fromJson(json['user'] as Map<String, dynamic>),
  userID: json['userID'] as String?,
  itemName: json['itemName'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  itemPrice: (json['itemPrice'] as num?)?.toDouble(),
  totalPrice: (json['totalPrice'] as num?)?.toDouble(),
  masterID: (json['masterID'] as num?)?.toInt(),
);

Map<String, dynamic> _$OrderDetailsResponseDtoToJson(
  OrderDetailsResponseDto instance,
) => <String, dynamic>{
  'orderID': instance.orderID,
  'user': instance.user,
  'userID': instance.userID,
  'itemName': instance.itemName,
  'quantity': instance.quantity,
  'itemPrice': instance.itemPrice,
  'totalPrice': instance.totalPrice,
  'masterID': instance.masterID,
};
