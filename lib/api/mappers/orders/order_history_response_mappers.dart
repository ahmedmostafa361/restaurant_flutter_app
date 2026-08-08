import 'package:restaurant_flutter_app/api/model/response/orders/order_details_dto.dart';

import '../../../domain/entinties/response/orders/order_history_details.dart';

extension OrderDetailsDtoMapper on OrderDetailsDto {
  OrderDetails toDomain() {
    return OrderDetails(
      masterID: masterID,
      userID: userID,
      userCode: userCode,
      restaurantID: restaurantID,
      grandTotal: grandTotal,
    );
  }
}
