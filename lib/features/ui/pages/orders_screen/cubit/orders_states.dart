import '../../../../../domain/entinties/response/orders/master_order.dart';

abstract class CheckoutStates {}

class CheckoutInitialState extends CheckoutStates {}

class CheckoutLoadingState extends CheckoutStates {}

class CheckoutSuccessState extends CheckoutStates {
  final MakeOrderResponse orderResult;

  CheckoutSuccessState({required this.orderResult});
}

class CheckoutErrorState extends CheckoutStates {
  final String errorMessage;

  CheckoutErrorState({required this.errorMessage});
}

// Distinct from a generic error — user needs to log in, not retry
class CheckoutNotAuthenticatedState extends CheckoutStates {}
