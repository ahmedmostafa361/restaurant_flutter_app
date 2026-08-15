import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_item_dto.dart';
import 'package:restaurant_flutter_app/data/repository/menu/menu_items_repository_impl.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockApiServices mockApiServices;
  late ItemsRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = ItemsRemoteDataSourceImpl(apiServices: mockApiServices);
  });

  group('ItemsRemoteDataSourceImpl', () {
    test('searchItems maps DTOs to domain entities on success', () async {
      final dtos = [
        MenuItemDto(itemID: 1, itemName: 'Fish Curry', itemPrice: 220.0),
      ];
      when(
        () => mockApiServices.getRestaurantItems('fish'),
      ).thenAnswer((_) async => dtos);

      final result = await dataSource.searchItems('fish');

      expect(result.length, 1);
      expect(result.first.itemName, 'Fish Curry');
    });

    test('searchItems passes null itemName through to apiServices', () async {
      when(
        () => mockApiServices.getRestaurantItems(null),
      ).thenAnswer((_) async => []);

      await dataSource.searchItems(null);

      verify(() => mockApiServices.getRestaurantItems(null)).called(1);
    });

    test('searchItems rethrows as ServerErrorException on failure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Restaurant/items'),
        error: AppException(errorMessage: 'Search failed'),
      );
      when(
        () => mockApiServices.getRestaurantItems('fish'),
      ).thenThrow(dioException);

      expect(
        () => dataSource.searchItems('fish'),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Search failed',
          ),
        ),
      );
    });
  });
}
