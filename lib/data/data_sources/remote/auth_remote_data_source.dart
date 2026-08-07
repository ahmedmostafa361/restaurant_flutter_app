import '../../../domain/entinties/request/register_request.dart';
import '../../../domain/entinties/response/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponse> register(RegisterRequest registerRequest);
}