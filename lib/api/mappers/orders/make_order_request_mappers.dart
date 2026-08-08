import 'package:restaurant_flutter_app/api/model/request/make_order_request_dto.dart';
import 'package:restaurant_flutter_app/api/model/request/order_item_request_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/make_order_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_item_response_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';

import '../../../domain/entinties/response/orders/master_order.dart';
import '../../../domain/entinties/response/orders/order_response.dart';


extension MakeOrderRequestMapper on MakeOrderRequest {
  MakeOrderRequestDto toDto() {
    return MakeOrderRequestDto(
      menuDTO: items
          .map((item) =>
          OrderItemRequestDto(
            itemName: item.itemName,
            quantity: item.quantity,
          ))
          .toList(),
    );
  }
}

extension OrderItemResponseDtoMapper on OrderItemResponseDto {
  OrderItemResponse toDomain() {
    return OrderItemResponse(
      orderID: orderID,
      userID: userID,
      itemName: itemName,
      quantity: quantity,
      itemPrice: itemPrice,
      totalPrice: totalPrice,
      masterID: masterID,
    );
  }
}

extension MakeOrderResponseDtoMapper on MakeOrderResponseDto {
  MakeOrderResponse toDomain() {
    return MakeOrderResponse(
      fullOrder: (fullOrder ?? []).map((dto) => dto.toDomain()).toList(),
      grandTotal: grandTotal,
    );
  }
}