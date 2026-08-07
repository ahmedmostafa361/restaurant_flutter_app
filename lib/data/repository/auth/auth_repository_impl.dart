import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';

import '../../../domain/repository/auth_repository.dart';
import '../../data_sources/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserResponse> register(RegisterRequest registerRequest) {
    return remoteDataSource.register(registerRequest);
  }
}