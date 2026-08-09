import 'package:restaurant_flutter_app/api/mappers/orders/order_details_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/delete_order_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_order.dart';

extension DeleteOrderDtoMapper on DeleteOrderDto {
  DeleteOrder toDomain() {
    return DeleteOrder(message: message, orderExists: orderExists?.toDomain());
  }
}
