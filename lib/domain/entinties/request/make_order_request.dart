// make_order_request.dart
import 'order_item_request.dart';

class MakeOrderRequest {
  final int restaurantId;
  final List<OrderItemRequest> items;

  MakeOrderRequest({required this.restaurantId, required this.items});
}