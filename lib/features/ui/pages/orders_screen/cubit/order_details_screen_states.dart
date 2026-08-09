import '../../../../../domain/entinties/response/orders/order_details.dart';

abstract class OrderDetailsScreenStates {}

class OrderDetailsScreenInitialState extends OrderDetailsScreenStates {}

class OrderDetailsScreenLoadingState extends OrderDetailsScreenStates {}

class OrderDetailsScreenSuccessState extends OrderDetailsScreenStates {
  final List<OrderDetails> orderDetails;

  OrderDetailsScreenSuccessState({required this.orderDetails});
}

class OrderDetailsScreenErrorState extends OrderDetailsScreenStates {
  final String errorMessage;

  OrderDetailsScreenErrorState({required this.errorMessage});
}

class OrderDetailsScreenDeleteSuccessState extends OrderDetailsScreenStates {
  final int deletedOrderId;

  OrderDetailsScreenDeleteSuccessState({required this.deletedOrderId});
}
