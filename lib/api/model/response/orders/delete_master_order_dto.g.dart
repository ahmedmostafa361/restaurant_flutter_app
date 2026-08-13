// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_master_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteMasterOrderDto _$DeleteMasterOrderDtoFromJson(
  Map<String, dynamic> json,
) => DeleteMasterOrderDto(
  message: json['message'] as String?,
  orderExists: (json['orderexits'] as List<dynamic>?)
      ?.map((e) => MasterOrderExistsDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  singleOrders: (json['singleorders'] as List<dynamic>?)
      ?.map((e) => OrderDetailsResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DeleteMasterOrderDtoToJson(
  DeleteMasterOrderDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'orderexits': instance.orderExists,
  'singleorders': instance.singleOrders,
};
