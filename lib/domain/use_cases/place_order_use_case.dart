import '../entinties/request/make_order_request.dart';
import '../entinties/response/orders/master_order.dart';
import '../repository/orders/orders_repository.dart';

class PlaceOrderUseCase {
  OrdersRepository ordersRepository;

  PlaceOrderUseCase(this.ordersRepository);

  Future<MakeOrderResponse> invoke(MakeOrderRequest request, String apikey) {
    return ordersRepository.makeOrder(request, apikey);
  }
}
