import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_code_login_response.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/login_request.dart';

import '../../../domain/repository/auth/auth_repository.dart';
import '../../data_sources/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserResponse> register(RegisterRequest registerRequest) {
    return remoteDataSource.register(registerRequest);
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return remoteDataSource.login(loginRequest);
  }
}