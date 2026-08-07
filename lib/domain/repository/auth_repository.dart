import '../entinties/request/register_request.dart';
import '../entinties/response/user_response.dart';

abstract class AuthRepository {
  Future<UserResponse> register(RegisterRequest registerRequest);
}