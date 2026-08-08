// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemResponseDto _$OrderItemResponseDtoFromJson(
  Map<String, dynamic> json,
) => OrderItemResponseDto(
  orderID: (json['orderID'] as num?)?.toInt(),
  userID: json['userID'] as String?,
  itemName: json['itemName'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  itemPrice: (json['itemPrice'] as num?)?.toDouble(),
  totalPrice: (json['totalPrice'] as num?)?.toDouble(),
  masterID: (json['masterID'] as num?)?.toInt(),
);

Map<String, dynamic> _$OrderItemResponseDtoToJson(
  OrderItemResponseDto instance,
) => <String, dynamic>{
  'orderID': instance.orderID,
  'userID': instance.userID,
  'itemName': instance.itemName,
  'quantity': instance.quantity,
  'itemPrice': instance.itemPrice,
  'totalPrice': instance.totalPrice,
  'masterID': instance.masterID,
};
