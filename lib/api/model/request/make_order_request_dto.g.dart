// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderRequestDto _$MakeOrderRequestDtoFromJson(Map<String, dynamic> json) =>
    MakeOrderRequestDto(
      menuDTO: (json['menuDTO'] as List<dynamic>)
          .map((e) => OrderItemRequestDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MakeOrderRequestDtoToJson(
  MakeOrderRequestDto instance,
) => <String, dynamic>{'menuDTO': instance.menuDTO};
