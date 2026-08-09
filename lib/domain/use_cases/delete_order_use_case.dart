import '../entinties/response/orders/delete_order.dart';
import '../repository/orders/orders_repository.dart';

import 'package:injectable/injectable.dart';

@injectable
class DeleteOrderUseCase {
  OrdersRepository ordersRepository;

  DeleteOrderUseCase(this.ordersRepository);

  Future<DeleteOrder> invoke(int orderId, String apikey) {
    return ordersRepository.deleteSingleOrderById(orderId, apikey);
  }
}
