import 'package:json_annotation/json_annotation.dart';

part 'user_code_login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  @JsonKey(name: "usercode")
  final String? userCode;

  LoginResponseDto({this.userCode});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseDtoToJson(this);
  }
}
