import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_response.dart';
import 'package:restaurant_flutter_app/features/ui/register_screen/cubit/register_state.dart';
import 'package:restaurant_flutter_app/features/ui/register_screen/cubit/register_view_model.dart';

import '../../../../../helpers/mock_classes.dart';

class FakeRegisterRequest extends Fake implements RegisterRequest {}

void main() {
  late MockRegisterUseCase mockRegisterUseCase;

  setUpAll(() {
    registerFallbackValue(FakeRegisterRequest());
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
  });

  group('RegisterViewModel — validation', () {
    blocTest<RegisterViewModel, RegisterStates>(
      'emits ValidationErrorState when fields are empty',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (cubit) =>
          cubit.register(email: '', password: '', confirmPassword: ''),
      expect: () => [isA<RegisterValidationErrorState>()],
      verify: (_) {
        verifyNever(() => mockRegisterUseCase.invoke(any()));
      },
    );

    blocTest<RegisterViewModel, RegisterStates>(
      'emits ValidationErrorState for an invalid email format',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (cubit) =>
          cubit.register(
            email: 'not-an-email',
            password: 'sonicmaster1',
            confirmPassword: 'sonicmaster1',
          ),
      expect: () => [isA<RegisterValidationErrorState>()],
    );

    blocTest<RegisterViewModel, RegisterStates>(
      'emits ValidationErrorState when password is too short',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (cubit) =>
          cubit.register(
            email: 'ahmed@bachelor.com',
            password: '123',
            confirmPassword: '123',
          ),
      expect: () =>
      [
        isA<RegisterValidationErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'strong password please'),
      ],
    );

    blocTest<RegisterViewModel, RegisterStates>(
      'emits ValidationErrorState when passwords do not match',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (cubit) =>
          cubit.register(
            email: 'ahmed@bachelor.com',
            password: 'sonicmaster1',
            confirmPassword: 'differentpassword',
          ),
      expect: () =>
      [
        isA<RegisterValidationErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Passwords not matching'),
      ],
      verify: (_) {
        verifyNever(() => mockRegisterUseCase.invoke(any()));
      },
    );
  });

  group('RegisterViewModel — register flow', () {
    blocTest<RegisterViewModel, RegisterStates>(
      'emits [Loading, Success] on valid registration',
      build: () {
        when(() => mockRegisterUseCase.invoke(any())).thenAnswer(
              (_) async =>
              UserResponse(
                userEmail: 'ahmed@bachelor.com',
                password: 'sonicmaster1',
                userCode: null,
              ),
        );
        return RegisterViewModel(mockRegisterUseCase);
      },
      act: (cubit) =>
          cubit.register(
            email: 'ahmed@bachelor.com',
            password: 'sonicmaster1',
            confirmPassword: 'sonicmaster1',
          ),
      expect: () =>
      [
        isA<RegisterLoadingState>(),
        isA<RegisterSuccessState>(),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase.invoke(any())).called(1);
      },
    );

    blocTest<RegisterViewModel, RegisterStates>(
      'emits [Loading, Error] when the use case throws ServerErrorException',
      build: () {
        when(() => mockRegisterUseCase.invoke(any()))
            .thenThrow(
            ServerErrorException(errorMessage: 'Email already exists'));
        return RegisterViewModel(mockRegisterUseCase);
      },
      act: (cubit) =>
          cubit.register(
            email: 'ahmed@bachelor.com',
            password: 'sonicmaster1',
            confirmPassword: 'sonicmaster1',
          ),
      expect: () =>
      [
        isA<RegisterLoadingState>(),
        isA<RegisterErrorState>().having((s) => s.errorMessage, 'errorMessage',
            'Email already exists'),
      ],
    );

    blocTest<RegisterViewModel, RegisterStates>(
      'emits [Loading, Error] with fallback message for unexpected exceptions',
      build: () {
        when(() => mockRegisterUseCase.invoke(any())).thenThrow(
            Exception('unexpected'));
        return RegisterViewModel(mockRegisterUseCase);
      },
      act: (cubit) =>
          cubit.register(
            email: 'ahmed@bachelor.com',
            password: 'sonicmaster1',
            confirmPassword: 'sonicmaster1',
          ),
      expect: () =>
      [
        isA<RegisterLoadingState>(),
        isA<RegisterErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Something went wrong, please try again.'),
      ],
    );
  });
}