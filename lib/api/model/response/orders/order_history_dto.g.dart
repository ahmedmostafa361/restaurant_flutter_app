// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsHistoryDto _$OrderDetailsHistoryDtoFromJson(
  Map<String, dynamic> json,
) => OrderDetailsHistoryDto(
  masterID: (json['masterID'] as num?)?.toInt(),
  userID: json['userID'] as String?,
  userCode: json['usercode'] as String?,
  restaurantID: (json['restaurantID'] as num?)?.toInt(),
  grandTotal: (json['grandtotal'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OrderDetailsHistoryDtoToJson(
  OrderDetailsHistoryDto instance,
) => <String, dynamic>{
  'masterID': instance.masterID,
  'userID': instance.userID,
  'usercode': instance.userCode,
  'restaurantID': instance.restaurantID,
  'grandtotal': instance.grandTotal,
};
