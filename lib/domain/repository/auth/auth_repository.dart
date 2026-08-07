import '../../entinties/request/register_request.dart';
import '../../entinties/response/user_code_login_response.dart';
import '../../entinties/response/user_response.dart';
import 'login_request.dart';

abstract class AuthRepository {
  Future<UserResponse> register(RegisterRequest registerRequest);

  Future<LoginResponse> login(LoginRequest loginRequest);
}