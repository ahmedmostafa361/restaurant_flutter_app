import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_code_login_response.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/login_request.dart';
import 'package:restaurant_flutter_app/domain/use_cases/login_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  test(
      'invoke calls repository.login with the given request and returns its result', () async {
    final request = LoginRequest(
        email: 'ahmed@bachelor.com', password: 'sonicmaster1');
    final response = LoginResponse(
        userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
    when(() => mockRepository.login(request)).thenAnswer((_) async => response);

    final result = await useCase.invoke(request);

    expect(result, response);
    verify(() => mockRepository.login(request)).called(1);
  });
}