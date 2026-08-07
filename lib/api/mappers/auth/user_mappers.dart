import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';

extension UserResponseDtoMapper on UserResponseDto {
  UserResponse toDomain() {
    return UserResponse(
      userEmail: userEmail,
      password: password,
      userCode: userCode,
    );
  }
}