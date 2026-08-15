import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/data_sources/remote/restaurants/restaurants_remote_data_source_impl.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/api/model/response/restaurants/restaurant_dto.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockApiServices mockApiServices;
  late RestaurantsRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = RestaurantsRemoteDataSourceImpl(apiServices: mockApiServices);
  });

  group('RestaurantsRemoteDataSourceImpl', () {
    test('getRestaurants maps DTOs to domain entities on success', () async {
      final dtos = [
        RestaurantDto(restaurantID: 4, restaurantName: 'Paradise Biryani'),
      ];
      when(
        () => mockApiServices.getRestaurants(),
      ).thenAnswer((_) async => dtos);

      final result = await dataSource.getRestaurants();

      expect(result.length, 1);
      expect(result.first.restaurantName, 'Paradise Biryani');
    });

    test(
      'getRestaurants rethrows as ServerErrorException with the AppException message',
      () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/Restaurant'),
          error: AppException(errorMessage: 'Connection timeout'),
        );
        when(() => mockApiServices.getRestaurants()).thenThrow(dioException);

        expect(
          () => dataSource.getRestaurants(),
          throwsA(
            isA<ServerErrorException>().having(
              (e) => e.errorMessage,
              'errorMessage',
              'Connection timeout',
            ),
          ),
        );
      },
    );

    test('KNOWN GAP: getRestaurants collapses a NetworkErrorException into ServerErrorException, '
        'losing the original error type from DioInterceptors', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Restaurant'),
        error: NetworkErrorException(errorMessage: 'No internet connection'),
      );
      when(() => mockApiServices.getRestaurants()).thenThrow(dioException);

      // Documents current (arguably buggy) behavior: even though the interceptor
      // built a NetworkErrorException, this data source always rethrows ServerErrorException.
      // If this test starts failing after a fix, that's expected — update it to assert
      // isA<NetworkErrorException>() instead once the rethrow is corrected.
      await expectLater(
        () => dataSource.getRestaurants(),
        throwsA(isA<ServerErrorException>()),
      );
    });

    test(
      'getRestaurantById rethrows as ServerErrorException on failure',
      () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/Restaurant/5'),
          error: AppException(errorMessage: 'Restaurant not found'),
        );
        when(
          () => mockApiServices.getRestaurantById(5),
        ).thenThrow(dioException);

        expect(
          () => dataSource.getRestaurantById(5),
          throwsA(
            isA<ServerErrorException>().having(
              (e) => e.errorMessage,
              'errorMessage',
              'Restaurant not found',
            ),
          ),
        );
      },
    );
  });
}
