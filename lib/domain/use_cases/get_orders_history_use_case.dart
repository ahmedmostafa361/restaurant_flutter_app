import '../entinties/response/orders/order_history_details.dart';
import '../repository/orders/orders_history_repository.dart';

class GetOrdersUseCase {
  OrdersRepository ordersRepository;

  GetOrdersUseCase(this.ordersRepository);

  Future<List<OrderDetails>> invoke(String apikey) {
    return ordersRepository.getAllOrders(apikey);
  }
}
