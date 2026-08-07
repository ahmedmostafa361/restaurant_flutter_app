import '../entinties/response/user_code_login_response.dart';
import '../repository/auth/auth_repository.dart';
import '../repository/auth/login_request.dart';

class LoginUseCase {
  AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<LoginResponse> invoke(LoginRequest loginRequest) {
    return authRepository.login(loginRequest);
  }
}