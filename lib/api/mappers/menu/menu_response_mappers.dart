import 'package:restaurant_flutter_app/api/model/response/menu/menu_response_dto.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';

extension MenuResponseDtoMapper on MenuResponseDto {
  MenuResponse toDomain() {
    return MenuResponse(
      itemID: itemID,
      itemName: itemName,
      itemDescription: itemDescription,
      itemPrice: itemPrice,
      restaurantName: restaurantName,
      restaurantID: restaurantID,
      imageUrl: imageUrl,
    );
  }
}