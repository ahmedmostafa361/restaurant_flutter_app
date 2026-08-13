import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/repository/orders/orders_repository.dart';

import '../entinties/response/orders/delete_master_order.dart';

@injectable
class DeleteMasterOrderUseCase {
  OrdersRepository ordersRepository;

  DeleteMasterOrderUseCase(this.ordersRepository);

  Future<DeleteMasterOrder> invoke(int masterId, String apikey) {
    return ordersRepository.deleteMasterOrder(masterId, apikey);
  }
}
