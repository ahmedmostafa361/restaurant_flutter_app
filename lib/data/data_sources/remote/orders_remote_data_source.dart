import '../../../domain/entinties/request/make_order_request.dart';
import '../../../domain/entinties/response/orders/master_order.dart';
import '../../../domain/entinties/response/orders/order_history_details.dart';

abstract class OrdersRemoteDataSource {
  Future<MakeOrderResponse> makeOrder(MakeOrderRequest request, String apikey);

  Future<List<OrderDetails>> getAllOrders(String apikey);
}