import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDto {
  @JsonKey(name: "userEmail")
  final String? userEmail;
  @JsonKey(name: "password")
  final String? password;

  RegisterRequestDto({this.userEmail, this.password});

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterRequestDtoToJson(this);
  }
}
