import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/auth_repository.dart';

import '../entinties/request/register_request.dart';
import '../entinties/response/user_response.dart';

@injectable
class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<UserResponse> invoke(RegisterRequest registerRequest) {
    return authRepository.register(registerRequest);
  }
}