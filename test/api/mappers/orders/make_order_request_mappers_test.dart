import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/make_order_request_mappers.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/order_item_request.dart';

void main() {
  group('MakeOrderRequestMapper (domain -> DTO)', () {
    test('maps items list correctly to the request DTO', () {
      final request = MakeOrderRequest(
        restaurantId: 4,
        items: [
          OrderItemRequest(itemName: 'Chicken Biryani', quantity: 2),
          OrderItemRequest(itemName: 'Kofta Curry', quantity: 1),
        ],
      );

      final dto = request.toDto();

      expect(dto.menuDTO.length, 2);
      expect(dto.menuDTO[0].itemName, 'Chicken Biryani');
      expect(dto.menuDTO[0].quantity, 2);
      expect(dto.menuDTO[1].itemName, 'Kofta Curry');
      expect(dto.menuDTO[1].quantity, 1);
    });

    test('maps an empty items list without throwing', () {
      final request = MakeOrderRequest(restaurantId: 4, items: []);

      final dto = request.toDto();

      expect(dto.menuDTO, isEmpty);
    });
  });
}