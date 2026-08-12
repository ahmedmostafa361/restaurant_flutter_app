import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/data/repository/restaurants/restaurants_repository_impl.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockRestaurantsRemoteDataSource mockRemoteDataSource;
  late RestaurantsRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRestaurantsRemoteDataSource();
    repository =
        RestaurantsRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('RestaurantsRepositoryImpl', () {
    test(
        'getRestaurants delegates to the remote data source and returns its result', () async {
      final restaurants = [
        Restaurant(restaurantID: 4, restaurantName: 'Paradise Biryani'),
      ];
      when(() => mockRemoteDataSource.getRestaurants()).thenAnswer((
          _) async => restaurants);

      final result = await repository.getRestaurants();

      expect(result, restaurants);
      verify(() => mockRemoteDataSource.getRestaurants()).called(1);
    });

    test(
        'getRestaurants propagates exceptions from the remote data source', () async {
      when(() => mockRemoteDataSource.getRestaurants()).thenThrow(
          Exception('network error'));

      expect(() => repository.getRestaurants(), throwsException);
    });

    test(
        'getRestaurantById delegates with the correct id and returns its result', () async {
      final restaurant = Restaurant(
          restaurantID: 5, restaurantName: 'Paradise Biryani');
      when(() => mockRemoteDataSource.getRestaurantById(5)).thenAnswer((
          _) async => restaurant);

      final result = await repository.getRestaurantById(5);

      expect(result, restaurant);
      verify(() => mockRemoteDataSource.getRestaurantById(5)).called(1);
    });
  });
}