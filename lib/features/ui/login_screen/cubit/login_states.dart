abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

/// Clean success state - session state lives in AuthLocalStorage
class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}

class LoginValidationErrorState extends LoginStates {
  final String errorMessage;

  LoginValidationErrorState({required this.errorMessage});
}
