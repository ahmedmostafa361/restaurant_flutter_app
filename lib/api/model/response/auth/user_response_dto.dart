import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable()
class UserResponseDto {
  @JsonKey(name: "userEmail")
  final String? userEmail;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "usercode")
  final String? userCode;

  UserResponseDto({this.userEmail, this.password, this.userCode});

  factory UserResponseDto.fromJson(Map<String, dynamic> json) {
    return _$UserResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserResponseDtoToJson(this);
  }
}
