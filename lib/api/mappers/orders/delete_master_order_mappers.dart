import 'package:restaurant_flutter_app/api/mappers/orders/order_details_mappers.dart';
import 'package:restaurant_flutter_app/api/mappers/restaurants/restaurant_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/delete_master_order_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/master_order_exists_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_master_order.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/master_order_exists.dart';

extension MasterOrderExistsDtoMapper on MasterOrderExistsDto {
  MasterOrderExists toDomain() {
    return MasterOrderExists(
      masterID: masterID,
      userID: userID,
      restaurant: restaurant?.toDomain(),
      restaurantID: restaurantID,
      grandTotal: grandTotal,
    );
  }
}

extension DeleteMasterOrderDtoMapper on DeleteMasterOrderDto {
  DeleteMasterOrder toDomain() {
    return DeleteMasterOrder(
      message: message,
      orderExists: (orderExists ?? []).map((dto) => dto.toDomain()).toList(),
      singleOrders: (singleOrders ?? []).map((dto) => dto.toDomain()).toList(),
    );
  }
}
