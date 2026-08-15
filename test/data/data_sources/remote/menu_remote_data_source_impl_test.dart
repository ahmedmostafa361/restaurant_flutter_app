import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_response_dto.dart';
import 'package:restaurant_flutter_app/data/repository/menu/menu_repository_impl.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockApiServices mockApiServices;
  late MenuRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = MenuRemoteDataSourceImpl(apiServices: mockApiServices);
  });

  group('MenuRemoteDataSourceImpl', () {
    test('getMenu maps DTOs to domain entities on success', () async {
      final dtos = [
        MenuResponseDto(
          itemID: 1,
          itemName: 'Chicken Biryani',
          itemPrice: 280.0,
        ),
      ];
      when(
        () => mockApiServices.getMenu(5, null),
      ).thenAnswer((_) async => dtos);

      final result = await dataSource.getMenu(5, null);

      expect(result.length, 1);
      expect(result.first.itemName, 'Chicken Biryani');
    });

    test('getMenu passes sortByPrice through to apiServices', () async {
      final dtos = [
        MenuResponseDto(
          itemID: 1,
          itemName: 'Chicken Biryani',
          itemPrice: 280.0,
        ),
      ];
      when(
        () => mockApiServices.getMenu(5, 'asc'),
      ).thenAnswer((_) async => dtos);

      await dataSource.getMenu(5, 'asc');

      verify(() => mockApiServices.getMenu(5, 'asc')).called(1);
    });

    test('getMenu rethrows as ServerErrorException on failure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Restaurant/5/menu'),
        error: AppException(errorMessage: 'Menu unavailable'),
      );
      when(() => mockApiServices.getMenu(5, null)).thenThrow(dioException);

      expect(
        () => dataSource.getMenu(5, null),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Menu unavailable',
          ),
        ),
      );
    });
  });
}
