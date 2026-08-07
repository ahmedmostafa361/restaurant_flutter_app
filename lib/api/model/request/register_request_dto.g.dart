// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestDto _$RegisterRequestDtoFromJson(Map<String, dynamic> json) =>
    RegisterRequestDto(
      userEmail: json['userEmail'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterRequestDtoToJson(RegisterRequestDto instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'password': instance.password,
    };
