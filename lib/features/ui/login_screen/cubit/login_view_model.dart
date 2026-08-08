import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/auth_local_storage.dart';
import 'package:restaurant_flutter_app/domain/use_cases/login_use_case.dart';

import '../../../../../core/utlis/app_validators.dart';
import '../../../../api/dio/dio_exceptions/app_exceptions.dart';
import '../../../../domain/repository/auth/login_request.dart';
import 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;
  final AuthLocalStorage authLocalStorage;

  LoginViewModel(this.loginUseCase, this.authLocalStorage)
    : super(LoginInitialState());

  Future<void> login({required String email, required String password}) async {
    final validationError = _validate(email, password);
    if (validationError != null) {
      emit(LoginValidationErrorState(errorMessage: validationError));
      return;
    }

    emit(LoginLoadingState());

    try {
      final response = await loginUseCase.invoke(
        LoginRequest(email: email, password: password),
      );

      final userCode = response.userCode;
      if (userCode == null || userCode.trim().isEmpty) {
        emit(LoginErrorState(errorMessage: "Invalid email or password."));
        return;
      }

      await authLocalStorage.saveUserCode(userCode);
      emit(LoginSuccessState());
    } on ServerErrorException catch (e) {
      emit(LoginErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(
        LoginErrorState(
          errorMessage: "Something went wrong, please try again.",
        ),
      );
    }
  }

  String? _validate(String email, String password) {
    // 1. Validate email using AppValidators
    final emailError = AppValidators.validateEmail(email);
    if (emailError != null) {
      return emailError;
    }

    // 2. Validate password using AppValidators
    final passwordError = AppValidators.validatePassword(password);
    if (passwordError != null) {
      return passwordError;
    }

    return null;
  }
}