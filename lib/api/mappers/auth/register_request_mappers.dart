import 'package:restaurant_flutter_app/api/model/request/register_request_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';

extension RegisterRequestMapper on RegisterRequest {
  RegisterRequestDto toDto() {
    return RegisterRequestDto(
      userEmail: userEmail,
      password: password,
    );
  }
}