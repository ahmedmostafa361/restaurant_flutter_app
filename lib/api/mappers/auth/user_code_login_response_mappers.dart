import '../../../domain/entinties/response/user_code_login_response.dart';
import '../../model/response/auth/user_code_login_response_dto.dart';

extension LoginResponseDtoMapper on LoginResponseDto {
  LoginResponse toDomain() {
    return LoginResponse(userCode: userCode);
  }
}
