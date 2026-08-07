abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String errorMessage;

  RegisterErrorState({required this.errorMessage});
}

// Emitted by client-side validation before any network call is made
class RegisterValidationErrorState extends RegisterStates {
  final String errorMessage;

  RegisterValidationErrorState({required this.errorMessage});
}
