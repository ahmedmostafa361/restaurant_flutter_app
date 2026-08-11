import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/make_order_request_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/make_order_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_item_response_dto.dart';
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

  group('OrderItemResponseDtoMapper', () {
    test(
        'maps all fields correctly, matching the real POST /Order response', () {
      // Real response captured from POST /Order/{restaurantId}/makeorder
      final dto = OrderItemResponseDto(
        orderID: 215,
        userID: 'ahmed@bachelor.com',
        itemName: 'Chicken Biryani',
        quantity: 2,
        itemPrice: 280.0,
        totalPrice: 560.0,
        masterID: 150,
      );

      final domain = dto.toDomain();

      expect(domain.orderID, 215);
      expect(domain.userID, 'ahmed@bachelor.com');
      expect(domain.itemName, 'Chicken Biryani');
      expect(domain.quantity, 2);
      expect(domain.itemPrice, 280.0);
      expect(domain.totalPrice, 560.0);
      expect(domain.masterID, 150);
    });
  });

  group('MakeOrderResponseDtoMapper', () {
    test('maps fullOrder list and grandTotal correctly', () {
      final dto = MakeOrderResponseDto(
        fullOrder: [
          OrderItemResponseDto(
            orderID: 215,
            userID: 'ahmed@bachelor.com',
            itemName: 'Chicken Biryani',
            quantity: 2,
            itemPrice: 280.0,
            totalPrice: 560.0,
            masterID: 150,
          ),
        ],
        grandTotal: 560.0,
      );

      final domain = dto.toDomain();

      expect(domain.fullOrder.length, 1);
      expect(domain.fullOrder.first.itemName, 'Chicken Biryani');
      expect(domain.grandTotal, 560.0);
    });

    test('maps a null fullOrder to an empty list, not null', () {
      final dto = MakeOrderResponseDto(fullOrder: null, grandTotal: 0.0);

      final domain = dto.toDomain();

      expect(domain.fullOrder, isEmpty);
      expect(domain.fullOrder, isNotNull);
    });
  });
}