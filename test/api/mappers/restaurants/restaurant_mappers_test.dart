import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/mappers/restaurants/restaurant_mappers.dart';
import 'package:restaurant_flutter_app/api/model/response/restaurants/restaurant_dto.dart';

void main() {
  group('RestaurantDtoMapper', () {
    test('maps all fields correctly to domain', () {
      final dto = RestaurantDto(
        restaurantID: 4,
        restaurantName: 'Paradise Biryani',
        address: 'Hyderabad',
        type: 'Indian',
        parkingLot: true,
      );

      final domain = dto.toDomain();

      expect(domain.restaurantID, 4);
      expect(domain.restaurantName, 'Paradise Biryani');
      expect(domain.address, 'Hyderabad');
      expect(domain.type, 'Indian');
      expect(domain.parkingLot, true);
    });

    test('maps null fields to null without throwing', () {
      final dto = RestaurantDto();

      final domain = dto.toDomain();

      expect(domain.restaurantID, isNull);
      expect(domain.restaurantName, isNull);
      expect(domain.address, isNull);
      expect(domain.type, isNull);
      expect(domain.parkingLot, isNull);
    });
  });
}