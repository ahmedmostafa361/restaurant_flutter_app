import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/data/repository/auth/auth_repository_impl.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_code_login_response.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/login_request.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test(
    'register delegates to the remote data source and returns its result',
    () async {
      final request = RegisterRequest(
        userEmail: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      final response = UserResponse(
        userEmail: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      when(
        () => mockRemoteDataSource.register(request),
      ).thenAnswer((_) async => response);

      final result = await repository.register(request);

      expect(result, response);
      verify(() => mockRemoteDataSource.register(request)).called(1);
    },
  );

  test(
    'login delegates to the remote data source and returns its result',
    () async {
      final request = LoginRequest(
        email: 'ahmed@bachelor.com',
        password: 'sonicmaster1',
      );
      final response = LoginResponse(
        userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
      );
      when(
        () => mockRemoteDataSource.login(request),
      ).thenAnswer((_) async => response);

      final result = await repository.login(request);

      expect(result.userCode, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
      verify(() => mockRemoteDataSource.login(request)).called(1);
    },
  );
}
