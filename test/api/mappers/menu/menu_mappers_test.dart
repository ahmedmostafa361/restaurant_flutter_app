import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/menu/menu_response_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_response_dto.dart';

void main() {
  group('MenuResponseDtoMapper', () {
    test('maps all fields correctly to domain, including double price', () {
      final dto = MenuResponseDto(
        itemID: 1,
        itemName: 'Chicken Biryani',
        itemDescription: 'Spicy rice dish',
        itemPrice: 280.0,
        restaurantName: 'Paradise Biryani',
        restaurantID: 4,
        imageUrl: 'https://example.com/biryani.png',
      );

      final domain = dto.toDomain();

      expect(domain.itemID, 1);
      expect(domain.itemName, 'Chicken Biryani');
      expect(domain.itemDescription, 'Spicy rice dish');
      expect(domain.itemPrice, 280.0);
      expect(domain.itemPrice, isA<double>());
      expect(domain.restaurantName, 'Paradise Biryani');
      expect(domain.restaurantID, 4);
      expect(domain.imageUrl, 'https://example.com/biryani.png');
    });
  });
}
