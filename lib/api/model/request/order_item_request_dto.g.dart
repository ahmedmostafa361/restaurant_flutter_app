// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemRequestDto _$OrderItemRequestDtoFromJson(Map<String, dynamic> json) =>
    OrderItemRequestDto(
      itemName: json['itemName'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemRequestDtoToJson(
  OrderItemRequestDto instance,
) => <String, dynamic>{
  'itemName': instance.itemName,
  'quantity': instance.quantity,
};
