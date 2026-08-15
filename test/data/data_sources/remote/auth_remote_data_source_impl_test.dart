import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/data_sources/remote/auth/auth_remote_data_source_impl.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/api/model/request/register_request_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_code_login_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/login_request.dart';

import '../../../helpers/mock_classes.dart';

class FakeRegisterRequestDto extends Fake implements RegisterRequestDto {}

void main() {
  late MockApiServices mockApiServices;
  late AuthRemoteDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(FakeRegisterRequestDto());
  });

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = AuthRemoteDataSourceImpl(apiServices: mockApiServices);
  });

  group('AuthRemoteDataSourceImpl — register', () {
    test('maps DTO to domain on success', () async {
      final request = RegisterRequest(
        userEmail: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      final dto = UserResponseDto(
        userEmail: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      when(() => mockApiServices.register(any())).thenAnswer((_) async => dto);

      final result = await dataSource.register(request);

      expect(result.userEmail, 'ahmed@bachelor.com');
    });

    test('rethrows as ServerErrorException on failure', () async {
      final request = RegisterRequest(
        userEmail: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/User/register'),
        error: AppException(errorMessage: 'Email already exists'),
      );
      when(() => mockApiServices.register(any())).thenThrow(dioException);

      expect(
        () => dataSource.register(request),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Email already exists',
          ),
        ),
      );
    });
  });

  group('AuthRemoteDataSourceImpl — login', () {
    test('maps DTO to domain on success', () async {
      final request = LoginRequest(
        email: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      final dto = LoginResponseDto(
        userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
      );
      when(
        () => mockApiServices.login('ahmed@bachelor.com', 'sonicmaster1'),
      ).thenAnswer((_) async => dto);

      final result = await dataSource.login(request);

      expect(result.userCode, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
    });

    test('rethrows as ServerErrorException on failure', () async {
      final request = LoginRequest(
        email: 'ahmed@bachelor.com',
        password: 'wrongpassword1',
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/User/getusercode'),
        error: AppException(errorMessage: 'Invalid credentials'),
      );
      when(
        () => mockApiServices.login('ahmed@bachelor.com', 'wrongpassword1'),
      ).thenThrow(dioException);

      expect(
        () => dataSource.login(request),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Invalid credentials',
          ),
        ),
      );
    });
  });
}
