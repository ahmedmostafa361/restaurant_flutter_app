import '../../../../../domain/entinties/response/orders/order_history_details.dart';

abstract class OrdersHistoryStates {}

class OrdersHistoryInitialState extends OrdersHistoryStates {}

class OrdersHistoryLoadingState extends OrdersHistoryStates {}

class OrdersHistorySuccessState extends OrdersHistoryStates {
  final List<OrderDetails> orders;

  OrdersHistorySuccessState({required this.orders});
}

class OrdersHistoryEmptyState extends OrdersHistoryStates {}

class OrdersHistoryErrorState extends OrdersHistoryStates {
  final String errorMessage;

  OrdersHistoryErrorState({required this.errorMessage});
}

// Distinct from a generic error — user needs to log in, not retry
class OrdersHistoryNotAuthenticatedState extends OrdersHistoryStates {}
