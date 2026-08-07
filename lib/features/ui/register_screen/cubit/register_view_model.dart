import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/register_request.dart';
import 'package:restaurant_flutter_app/domain/use_cases/register_use_case.dart';
import 'package:restaurant_flutter_app/features/ui/register_screen/cubit/register_state.dart';

import '../../../../../core/utlis/app_validators.dart';
import '../../../../api/dio/dio_exceptions/app_exceptions.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterStates> {
  final RegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase) : super(RegisterInitialState());

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // 1. Run client-side validation
    final validationError = _validate(email, password, confirmPassword);
    if (validationError != null) {
      emit(RegisterValidationErrorState(errorMessage: validationError));
      return;
    }

    // 2. Emit loading & invoke register use case
    emit(RegisterLoadingState());
    try {
      await registerUseCase.invoke(
        RegisterRequest(userEmail: email, password: password),
      );
      emit(RegisterSuccessState());
    } on ServerErrorException catch (e) {
      emit(RegisterErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(RegisterErrorState(
        errorMessage: "Something went wrong, please try again.",
      ));
    }
  }

  /// Delegates checks directly to AppValidators methods
  String? _validate(String email, String password, String confirmPassword) {
    final emailError = AppValidators.validateEmail(email);
    if (emailError != null) return emailError;

    final passwordError = AppValidators.validatePassword(password);
    if (passwordError != null) return passwordError;

    final confirmPasswordError = AppValidators.validateConfirmPassword(
      confirmPassword,
      password,
    );
    if (confirmPasswordError != null) return confirmPasswordError;

    return null;
  }
}