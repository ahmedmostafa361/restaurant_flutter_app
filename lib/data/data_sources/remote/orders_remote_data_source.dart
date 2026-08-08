import '../../../domain/entinties/request/make_order_request.dart';
import '../../../domain/entinties/response/orders/master_order.dart';

abstract class OrdersRemoteDataSource {
  Future<MakeOrderResponse> makeOrder(MakeOrderRequest request, String apikey);
}