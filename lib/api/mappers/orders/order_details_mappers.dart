import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';

import '../../../domain/entinties/response/orders/order_details.dart';

extension OrderDetailsResponseDtoMapper on OrderDetailsResponseDto {
  OrderDetails toDomain() {
    return OrderDetails(
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
