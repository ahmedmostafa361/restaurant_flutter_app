// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteOrderDto _$DeleteOrderDtoFromJson(Map<String, dynamic> json) =>
    DeleteOrderDto(
      message: json['message'] as String?,
      orderExists: json['orderexits'] == null
          ? null
          : OrderDetailsResponseDto.fromJson(
              json['orderexits'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DeleteOrderDtoToJson(DeleteOrderDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'orderexits': instance.orderExists,
    };
