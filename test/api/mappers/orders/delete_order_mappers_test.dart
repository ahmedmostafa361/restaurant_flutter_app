import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/delete_order_mapper.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/delete_order_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';

void main() {
  group('DeleteOrderDtoMapper', () {
    test('maps message and nested orderExists correctly to domain', () {
      final dto = DeleteOrderDto(
        message: 'Order deleted successfully',
        orderExists: OrderDetailsResponseDto(
          orderID: 215,
          itemName: 'Chicken Biryani',
          quantity: 2,
          itemPrice: 280.0,
          totalPrice: 560.0,
          masterID: 150,
        ),
      );

      final domain = dto.toDomain();

      expect(domain.message, 'Order deleted successfully');
      expect(domain.orderExists, isNotNull);
      expect(domain.orderExists!.orderID, 215);
    });

    test('maps a null orderExists without throwing', () {
      final dto = DeleteOrderDto(message: 'Order not found', orderExists: null);

      final domain = dto.toDomain();

      expect(domain.message, 'Order not found');
      expect(domain.orderExists, isNull);
    });
  });
}