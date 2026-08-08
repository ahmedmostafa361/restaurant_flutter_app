import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';

import '../../../../data/data_sources/remote/orders_remote_data_source.dart';
import '../../../../domain/entinties/response/orders/master_order.dart';
import '../../../../domain/entinties/response/orders/order_history_details.dart';
import '../../../../domain/repository/orders/orders_history_repository.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MakeOrderResponse> makeOrder(MakeOrderRequest request, String apikey) {
    return remoteDataSource.makeOrder(request, apikey);
  }

  @override
  Future<List<OrderDetails>> getAllOrders(String apikey) {
    return remoteDataSource.getAllOrders(apikey);
  }
}