import '../../../domain/entinties/response/menu/menu_item.dart';
import '../../model/response/menu/menu_item_dto.dart';

extension MenuItemDtoMapper on MenuItemDto {
  MenuItem toDomain() {
    return MenuItem(
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