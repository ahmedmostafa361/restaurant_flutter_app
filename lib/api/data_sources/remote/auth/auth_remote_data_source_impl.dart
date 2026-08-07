import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/api/api_services.dart';
import 'package:restaurant_flutter_app/api/mappers/auth/register_request_mappers.dart';
import 'package:restaurant_flutter_app/api/mappers/auth/user_mappers.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';

import '../../../dio/dio_exceptions/app_exceptions.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<UserResponse> register(RegisterRequest registerRequest) async {
    try {
      var userResponse = await apiServices.register(registerRequest.toDto());
      return userResponse.toDomain();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}