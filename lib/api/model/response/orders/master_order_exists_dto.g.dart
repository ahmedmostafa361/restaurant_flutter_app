// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_order_exists_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterOrderExistsDto _$MasterOrderExistsDtoFromJson(
  Map<String, dynamic> json,
) => MasterOrderExistsDto(
  masterID: (json['masterID'] as num?)?.toInt(),
  user: json['user'] == null
      ? null
      : UserResponseDto.fromJson(json['user'] as Map<String, dynamic>),
  userID: json['userID'] as String?,
  restaurant: json['restaurant'] == null
      ? null
      : RestaurantDto.fromJson(json['restaurant'] as Map<String, dynamic>),
  restaurantID: (json['restaurantID'] as num?)?.toInt(),
  grandTotal: (json['grandTotal'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MasterOrderExistsDtoToJson(
  MasterOrderExistsDto instance,
) => <String, dynamic>{
  'masterID': instance.masterID,
  'user': instance.user,
  'userID': instance.userID,
  'restaurant': instance.restaurant,
  'restaurantID': instance.restaurantID,
  'grandTotal': instance.grandTotal,
};
