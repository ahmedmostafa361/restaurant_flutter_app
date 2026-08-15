import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/orders/delete_master_order_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/delete_master_order_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/master_order_exists_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/restaurants/restaurant_dto.dart';

void main() {
  group('MasterOrderExistsDtoMapper', () {
    test(
      'maps all fields correctly, including nested restaurant, matching the real API response',
      () {
        final dto = MasterOrderExistsDto(
          masterID: 153,
          user: UserResponseDto(
            userEmail: 'ahmed@bachelor.com',
            password: 'sonicmaster1',
            userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
          ),
          userID: 'ahmed@bachelor.com',
          restaurant: RestaurantDto(
            restaurantID: 4,
            restaurantName: 'Bawarchi',
            address: 'Hyderabad, RTC Cross Road, Telangana',
            type: 'Biryani',
            parkingLot: true,
          ),
          restaurantID: 4,
          grandTotal: 560.00,
        );

        final domain = dto.toDomain();

        expect(domain.masterID, 153);
        expect(domain.userID, 'ahmed@bachelor.com');
        expect(domain.restaurant, isNotNull);
        expect(domain.restaurant!.restaurantName, 'Bawarchi');
        expect(domain.restaurantID, 4);
        expect(domain.grandTotal, 560.00);
        expect(domain.grandTotal, isA<double>());
      },
    );

    test('maps a null restaurant without throwing', () {
      final dto = MasterOrderExistsDto(
        masterID: 153,
        userID: 'ahmed@bachelor.com',
        restaurant: null,
        restaurantID: 4,
        grandTotal: 560.00,
      );

      final domain = dto.toDomain();

      expect(domain.restaurant, isNull);
    });
  });

  group('DeleteMasterOrderDtoMapper', () {
    test('maps message, orderExists list, and singleOrders list correctly', () {
      final dto = DeleteMasterOrderDto(
        message: 'Master order Deleted',
        orderExists: [
          MasterOrderExistsDto(
            masterID: 153,
            userID: 'ahmed@bachelor.com',
            restaurant: RestaurantDto(
              restaurantID: 4,
              restaurantName: 'Bawarchi',
            ),
            restaurantID: 4,
            grandTotal: 560.00,
          ),
        ],
        singleOrders: [],
      );

      final domain = dto.toDomain();

      expect(domain.message, 'Master order Deleted');
      expect(domain.orderExists.length, 1);
      expect(domain.orderExists.first.masterID, 153);
      expect(domain.singleOrders, isEmpty);
    });

    test(
      'maps null orderExists and null singleOrders to empty lists, not null',
      () {
        final dto = DeleteMasterOrderDto(
          message: 'No orders found',
          orderExists: null,
          singleOrders: null,
        );

        final domain = dto.toDomain();

        expect(domain.orderExists, isEmpty);
        expect(domain.orderExists, isNotNull);
        expect(domain.singleOrders, isEmpty);
        expect(domain.singleOrders, isNotNull);
      },
    );
  });
}
