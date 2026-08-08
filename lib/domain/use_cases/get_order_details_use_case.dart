import '../entinties/response/orders/oreder_details.dart';
import '../repository/orders/orders_repository.dart';

class GetOrderDetailsUseCase {
  OrdersRepository ordersRepository;

  GetOrderDetailsUseCase(this.ordersRepository);

  Future<List<OrderDetails>> invoke(int masterId, String apikey) {
    return ordersRepository.getOrderDetailsById(masterId, apikey);
  }
}
