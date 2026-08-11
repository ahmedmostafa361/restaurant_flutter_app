import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/menu/menu_item_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_item_dto.dart';

void main() {
  group('MenuItemDtoMapper', () {
    test('maps all fields correctly to domain', () {
      final dto = MenuItemDto(
        itemID: 2,
        itemName: 'Fish Curry',
        itemDescription: 'Spicy fish dish',
        itemPrice: 220.0,
        restaurantName: 'Paradise Biryani',
        restaurantID: 4,
        imageUrl: null,
      );

      final domain = dto.toDomain();

      expect(domain.itemID, 2);
      expect(domain.itemName, 'Fish Curry');
      expect(domain.itemDescription, 'Spicy fish dish');
      expect(domain.itemPrice, 220.0);
      expect(domain.restaurantName, 'Paradise Biryani');
      expect(domain.restaurantID, 4);
      expect(domain.imageUrl, isNull);
    });
  });
}