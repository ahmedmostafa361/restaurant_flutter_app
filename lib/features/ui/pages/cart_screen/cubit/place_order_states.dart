import '../../../../../domain/entinties/response/orders/master_order.dart';

abstract class PlaceOrderStates {}

class PlaceOrderInitialState extends PlaceOrderStates {}

class PlaceOrderLoadingState extends PlaceOrderStates {}

class PlaceOrderSuccessState extends PlaceOrderStates {
  final MakeOrderResponse response;

  PlaceOrderSuccessState({required this.response});
}

class PlaceOrderErrorState extends PlaceOrderStates {
  final String errorMessage;

  PlaceOrderErrorState({required this.errorMessage});
}
