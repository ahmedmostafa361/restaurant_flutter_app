import '../../entinties/request/make_order_request.dart';
import '../../entinties/response/orders/master_order.dart';

abstract class OrdersRepository {
  Future<MakeOrderResponse> makeOrder(MakeOrderRequest request, String apikey);
}