import 'package:injectable/injectable.dart';

import '../entinties/response/orders/order_history_details.dart';
import '../repository/orders/orders_repository.dart';

@injectable
class GetOrdersUseCase {
  OrdersRepository ordersRepository;

  GetOrdersUseCase(this.ordersRepository);

  Future<List<OrderDetailsHistory>> invoke(String apikey) {
    return ordersRepository.getAllOrders(apikey);
  }
}
