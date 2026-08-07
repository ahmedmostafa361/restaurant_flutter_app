// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      userEmail: json['userEmail'] as String?,
      password: json['password'] as String?,
      userCode: json['usercode'] as String?,
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'password': instance.password,
      'usercode': instance.userCode,
    };
