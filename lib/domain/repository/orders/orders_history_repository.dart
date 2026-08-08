import '../../entinties/request/make_order_request.dart';
import '../../entinties/response/orders/master_order.dart';
import '../../entinties/response/orders/order_history_details.dart';

abstract class OrdersRepository {
  Future<MakeOrderResponse> makeOrder(MakeOrderRequest request, String apikey);

  Future<List<OrderDetails>> getAllOrders(String apikey);
}