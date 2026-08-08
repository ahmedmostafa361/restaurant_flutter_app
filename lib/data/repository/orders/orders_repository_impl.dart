import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/api/api_services.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/make_order_request_mappers.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/orders_remote_data_source.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';

import '../../../api/dio/dio_exceptions/app_exceptions.dart';
import '../../../domain/entinties/response/orders/master_order.dart';


@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiServices apiServices;

  OrdersRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<MakeOrderResponse> makeOrder(MakeOrderRequest request,
      String apikey) async {
    try {
      var response = await apiServices.makeOrder(
        request.restaurantId,
        apikey,
        request.toDto(),
      );
      return response.toDomain();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}