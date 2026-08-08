// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderResponseDto _$MakeOrderResponseDtoFromJson(
  Map<String, dynamic> json,
) => MakeOrderResponseDto(
  fullOrder: (json['fullorder'] as List<dynamic>?)
      ?.map((e) => OrderItemResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  grandTotal: (json['grandTotal'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MakeOrderResponseDtoToJson(
  MakeOrderResponseDto instance,
) => <String, dynamic>{
  'fullorder': instance.fullOrder,
  'grandTotal': instance.grandTotal,
};
