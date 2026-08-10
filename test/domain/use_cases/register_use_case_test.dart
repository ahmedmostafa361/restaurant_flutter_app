import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';
import 'package:restaurant_flutter_app/domain/use_cases/register_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockAuthRepository mockRepository;
  late RegisterUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockRepository);
  });

  test(
      'invoke calls repository.register with the given request and returns its result', () async {
    final request = RegisterRequest(
        userEmail: 'ahmed@bachelor.com', password: 'sonicmaster1');
    final response = UserResponse(
        userEmail: 'ahmed@bachelor.com', password: 'sonicmaster1');
    when(() => mockRepository.register(request)).thenAnswer((
        _) async => response);

    final result = await useCase.invoke(request);

    expect(result, response);
    verify(() => mockRepository.register(request)).called(1);
  });
}