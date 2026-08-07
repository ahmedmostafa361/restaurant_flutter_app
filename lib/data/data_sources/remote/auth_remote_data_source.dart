import '../../../domain/entinties/request/register_request.dart';
import '../../../domain/entinties/response/user_code_login_response.dart';
import '../../../domain/entinties/response/user_response.dart';
import '../../../domain/repository/auth/login_request.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponse> register(RegisterRequest registerRequest);

  Future<LoginResponse> login(LoginRequest loginRequest);
}