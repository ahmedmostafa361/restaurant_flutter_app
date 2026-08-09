import 'package:injectable/injectable.dart';

import '../entinties/response/orders/order_details.dart';
import '../repository/orders/orders_repository.dart';

@injectable
class GetOrderDetailsUseCase {
  OrdersRepository ordersRepository;

  GetOrderDetailsUseCase(this.ordersRepository);

  Future<List<OrderDetails>> invoke(int masterId, String apikey) {
    return ordersRepository.getOrderDetailsById(masterId, apikey);
  }
}
