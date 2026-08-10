import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/user_code_login_response.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/login_request.dart';
import 'package:restaurant_flutter_app/features/ui/login_screen/cubit/login_states.dart';
import 'package:restaurant_flutter_app/features/ui/login_screen/cubit/login_view_model.dart';

import '../../../../../helpers/mock_classes.dart';

// Fake needed only for registerFallbackValue — never actually used/interacted with
class FakeLoginRequest extends Fake implements LoginRequest {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockAuthLocalStorage mockAuthLocalStorage;

  setUpAll(() {
    registerFallbackValue(FakeLoginRequest());
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockAuthLocalStorage = MockAuthLocalStorage();
    when(() => mockAuthLocalStorage.saveUserCode(any())).thenAnswer((
        _) async {});
  });

  group('LoginViewModel — validation', () {
    blocTest<LoginViewModel, LoginStates>(
      'emits ValidationErrorState when email is empty',
      build: () => LoginViewModel(mockLoginUseCase, mockAuthLocalStorage),
      act: (cubit) => cubit.login(email: '', password: 'sonicmaster1'),
      expect: () => [isA<LoginValidationErrorState>()],
      verify: (_) {
        verifyNever(() => mockLoginUseCase.invoke(any()));
      },
    );

    blocTest<LoginViewModel, LoginStates>(
      'emits ValidationErrorState when password is empty',
      build: () => LoginViewModel(mockLoginUseCase, mockAuthLocalStorage),
      act: (cubit) => cubit.login(email: 'ahmed@bachelor.com', password: ''),
      expect: () => [isA<LoginValidationErrorState>()],
    );

    blocTest<LoginViewModel, LoginStates>(
      'emits ValidationErrorState for an invalid email format',
      build: () => LoginViewModel(mockLoginUseCase, mockAuthLocalStorage),
      act: (cubit) =>
          cubit.login(email: 'not-an-email', password: 'sonicmaster1'),
      expect: () => [isA<LoginValidationErrorState>()],
      verify: (_) {
        verifyNever(() => mockLoginUseCase.invoke(any()));
      },
    );
  });

  group('LoginViewModel — login flow', () {
    blocTest<LoginViewModel, LoginStates>(
      'emits [Loading, Success] and saves userCode on valid credentials',
      build: () {
        when(() => mockLoginUseCase.invoke(any()))
            .thenAnswer((_) async =>
            LoginResponse(userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9'));
        return LoginViewModel(mockLoginUseCase, mockAuthLocalStorage);
      },
      act: (cubit) =>
          cubit.login(email: 'ahmed@bachelor.com', password: 'sonicmaster1'),
      expect: () =>
      [
        isA<LoginLoadingState>(),
        isA<LoginSuccessState>(),
      ],
      verify: (_) {
        verify(() =>
            mockAuthLocalStorage.saveUserCode(
                'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9')).called(1);
      },
    );

    blocTest<LoginViewModel, LoginStates>(
      'emits [Loading, Error] when the API returns a null userCode',
      build: () {
        when(() => mockLoginUseCase.invoke(any()))
            .thenAnswer((_) async => LoginResponse(userCode: null));
        return LoginViewModel(mockLoginUseCase, mockAuthLocalStorage);
      },
      act: (cubit) =>
          cubit.login(email: 'ahmed@bachelor.com', password: 'wrongpassword1'),
      expect: () =>
      [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>().having((s) => s.errorMessage, 'errorMessage',
            'Invalid email or password.'),
      ],
      verify: (_) {
        verifyNever(() => mockAuthLocalStorage.saveUserCode(any()));
      },
    );

    blocTest<LoginViewModel, LoginStates>(
      'emits [Loading, Error] when the API returns an empty-string userCode',
      build: () {
        when(() => mockLoginUseCase.invoke(any()))
            .thenAnswer((_) async => LoginResponse(userCode: ''));
        return LoginViewModel(mockLoginUseCase, mockAuthLocalStorage);
      },
      act: (cubit) =>
          cubit.login(email: 'ahmed@bachelor.com', password: 'wrongpassword1'),
      expect: () =>
      [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>(),
      ],
    );
    blocTest<LoginViewModel, LoginStates>(
      'emits [Loading, Error] when the use case throws ServerErrorException',
      build: () {
        when(() => mockLoginUseCase.invoke(any()))
            .thenThrow(ServerErrorException(errorMessage: 'Network error'));
        return LoginViewModel(mockLoginUseCase, mockAuthLocalStorage);
      },
      act: (cubit) =>
          cubit.login(email: 'ahmed@bachelor.com', password: 'sonicmaster1'),
      expect: () =>
      [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>().having((s) => s.errorMessage, 'errorMessage',
            'Network error'),
      ],
    );

    blocTest<LoginViewModel, LoginStates>(
      'emits [Loading, Error] with fallback message for unexpected exceptions',
      build: () {
        when(() => mockLoginUseCase.invoke(any())).thenThrow(
            Exception('unexpected'));
        return LoginViewModel(mockLoginUseCase, mockAuthLocalStorage);
      },
      act: (cubit) =>
          cubit.login(email: 'ahmed@bachelor.com', password: 'sonicmaster1'),
      expect: () =>
      [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Something went wrong, please try again.'),
      ],
    );
  });
}