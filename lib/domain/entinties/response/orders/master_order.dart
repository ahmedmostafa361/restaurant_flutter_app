// make_order_response.dart
import 'order_response.dart';

class MakeOrderResponse {
  final List<OrderItemResponse> fullOrder;
  final double? grandTotal;

  MakeOrderResponse({required this.fullOrder, this.grandTotal});
}