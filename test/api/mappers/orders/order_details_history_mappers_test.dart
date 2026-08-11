import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/order_history_response_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_history_dto.dart';

void main() {
  group('OrderDetailsDtoMapper (history — GET /Order)', () {
    test('maps all fields correctly, matching the real API response', () {
      // Real response captured from GET /Order?apikey=
      final dto = OrderDetailsHistoryDto(
        masterID: 150,
        userID: 'ahmed@bachelor.com',
        userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
        restaurantID: 4,
        grandTotal: 560.00,
      );

      final domain = dto.toDomain();

      expect(domain.masterID, 150);
      expect(domain.userID, 'ahmed@bachelor.com');
      expect(domain.userCode, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
      expect(domain.restaurantID, 4);
      expect(domain.grandTotal, 560.00);
      expect(
        domain.grandTotal,
        isA<double>(),
      ); // guards against the int/double bug we caught earlier
    });
  });
}
