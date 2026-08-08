// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsDto _$OrderDetailsDtoFromJson(Map<String, dynamic> json) =>
    OrderDetailsDto(
      masterID: (json['masterID'] as num?)?.toInt(),
      userID: json['userID'] as String?,
      userCode: json['usercode'] as String?,
      restaurantID: (json['restaurantID'] as num?)?.toInt(),
      grandTotal: (json['grandtotal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderDetailsDtoToJson(OrderDetailsDto instance) =>
    <String, dynamic>{
      'masterID': instance.masterID,
      'userID': instance.userID,
      'usercode': instance.userCode,
      'restaurantID': instance.restaurantID,
      'grandtotal': instance.grandTotal,
    };
