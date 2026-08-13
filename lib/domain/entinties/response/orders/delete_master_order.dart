import 'master_order_exists.dart';
import 'order_details.dart';

class DeleteMasterOrder {
  final String? message;
  final List<MasterOrderExists> orderExists;
  final List<OrderDetails> singleOrders;

  DeleteMasterOrder({
    this.message,
    required this.orderExists,
    required this.singleOrders,
  });
}
