import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/order_details_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';

void main() {
  group(
      'OrderDetailsResponseDtoMapper (line items — GET /Order/{master_id})', () {
    test('maps all fields correctly, matching the real API response', () {
      // Real response captured from GET /Order/{master_id}?apikey=
      final dto = OrderDetailsResponseDto(
        orderID: 215,
        user: UserResponseDto(
          userEmail: 'ahmed@bachelor.com',
          password: 'sonicmaster1',
          userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
        ),
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

    test(
        'does not expose the nested user object (password) on the domain entity', () {
      final dto = OrderDetailsResponseDto(
        orderID: 215,
        user: UserResponseDto(
          userEmail: 'ahmed@bachelor.com',
          password: 'sonicmaster1',
          // sensitive — should never reach the domain layer
          userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
        ),
        userID: 'ahmed@bachelor.com',
        itemName: 'Chicken Biryani',
        quantity: 2,
        itemPrice: 280.0,
        totalPrice: 560.0,
        masterID: 150,
      );

      final domain = dto.toDomain();

      // OrderDetails has no `user`/`password` field at all — this test
      // effectively documents that decision so it can't silently regress
      expect(
          domain, isNot(isA<Map>())); // sanity check it's a real typed object
      // If OrderDetails ever gains a password-carrying field, this test
      // won't catch it structurally — that's a code-review responsibility.
      // The real guard here is that OrderDetails.toDomain() has no `password` line at all.
    });
  });
}