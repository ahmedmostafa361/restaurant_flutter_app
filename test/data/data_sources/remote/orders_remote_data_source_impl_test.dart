import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/api/model/request/make_order_request_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/delete_master_order_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/delete_order_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/make_order_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_history_dto.dart';
import 'package:restaurant_flutter_app/data/repository/orders/orders_repository_impl.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';

import '../../../helpers/mock_classes.dart';

class FakeMakeOrderRequestDto extends Fake implements MakeOrderRequestDto {}

void main() {
  late MockApiServices mockApiServices;
  late OrdersRemoteDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(FakeMakeOrderRequestDto());
  });

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = OrdersRemoteDataSourceImpl(apiServices: mockApiServices);
  });

  group('OrdersRemoteDataSourceImpl — makeOrder', () {
    test('maps DTO to domain on success', () async {
      final request = MakeOrderRequest(restaurantId: 4, items: []);
      final dto = MakeOrderResponseDto(fullOrder: [], grandTotal: 560.0);
      when(
        () => mockApiServices.makeOrder(4, 'apikey123', any()),
      ).thenAnswer((_) async => dto);

      final result = await dataSource.makeOrder(request, 'apikey123');

      expect(result.grandTotal, 560.0);
    });

    test('rethrows as ServerErrorException on failure', () async {
      final request = MakeOrderRequest(restaurantId: 4, items: []);
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Order/4/makeorder'),
        error: AppException(errorMessage: 'Order failed'),
      );
      when(
        () => mockApiServices.makeOrder(4, 'apikey123', any()),
      ).thenThrow(dioException);

      expect(
        () => dataSource.makeOrder(request, 'apikey123'),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Order failed',
          ),
        ),
      );
    });
  });

  group('OrdersRemoteDataSourceImpl — getAllOrders', () {
    test('maps DTOs to domain on success', () async {
      final dtos = [
        OrderDetailsHistoryDto(
          masterID: 150,
          userID: 'ahmed@bachelor.com',
          restaurantID: 4,
          grandTotal: 560.0,
        ),
      ];
      when(
        () => mockApiServices.getAllOrders('apikey123'),
      ).thenAnswer((_) async => dtos);

      final result = await dataSource.getAllOrders('apikey123');

      expect(result.length, 1);
      expect(result.first.masterID, 150);
    });

    test('rethrows as ServerErrorException on failure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Order'),
        error: AppException(errorMessage: 'Failed to load orders'),
      );
      when(
        () => mockApiServices.getAllOrders('apikey123'),
      ).thenThrow(dioException);

      expect(
        () => dataSource.getAllOrders('apikey123'),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Failed to load orders',
          ),
        ),
      );
    });
  });

  group('OrdersRemoteDataSourceImpl — getOrderDetailsById', () {
    test('maps DTOs to domain on success', () async {
      final dtos = [
        OrderDetailsResponseDto(
          orderID: 215,
          itemName: 'Chicken Biryani',
          quantity: 2,
          itemPrice: 280.0,
          totalPrice: 560.0,
          masterID: 150,
        ),
      ];
      when(
        () => mockApiServices.getAllOrdersDetailsById(150, 'apikey123'),
      ).thenAnswer((_) async => dtos);

      final result = await dataSource.getOrderDetailsById(150, 'apikey123');

      expect(result.length, 1);
      expect(result.first.itemName, 'Chicken Biryani');
    });

    test('rethrows as ServerErrorException on failure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Order/150'),
        error: AppException(errorMessage: 'Order not found'),
      );
      when(
        () => mockApiServices.getAllOrdersDetailsById(150, 'apikey123'),
      ).thenThrow(dioException);

      expect(
        () => dataSource.getOrderDetailsById(150, 'apikey123'),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Order not found',
          ),
        ),
      );
    });
  });

  group('OrdersRemoteDataSourceImpl — deleteSingleOrderById', () {
    test('maps DTO to domain on success', () async {
      final dto = DeleteOrderDto(message: 'Order deleted', orderExists: null);
      when(
        () => mockApiServices.deleteSingleOrderById(215, 'apikey123'),
      ).thenAnswer((_) async => dto);

      final result = await dataSource.deleteSingleOrderById(215, 'apikey123');

      expect(result.message, 'Order deleted');
    });

    test('rethrows as ServerErrorException on failure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Order/215'),
        error: AppException(errorMessage: 'Delete failed'),
      );
      when(
        () => mockApiServices.deleteSingleOrderById(215, 'apikey123'),
      ).thenThrow(dioException);

      expect(
        () => dataSource.deleteSingleOrderById(215, 'apikey123'),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Delete failed',
          ),
        ),
      );
    });
  });

  group('OrdersRemoteDataSourceImpl — deleteMasterOrder', () {
    test('maps DTO to domain on success', () async {
      final dto = DeleteMasterOrderDto(
        message: 'Master order deleted',
        orderExists: [],
        singleOrders: [],
      );
      when(
        () => mockApiServices.deleteMasterOrder(150, 'apikey123'),
      ).thenAnswer((_) async => dto);

      final result = await dataSource.deleteMasterOrder(150, 'apikey123');

      expect(result.message, 'Master order deleted');
    });

    test('rethrows as ServerErrorException on failure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/Order/master/150'),
        error: AppException(errorMessage: 'Master delete failed'),
      );
      when(
        () => mockApiServices.deleteMasterOrder(150, 'apikey123'),
      ).thenThrow(dioException);

      expect(
        () => dataSource.deleteMasterOrder(150, 'apikey123'),
        throwsA(
          isA<ServerErrorException>().having(
            (e) => e.errorMessage,
            'errorMessage',
            'Master delete failed',
          ),
        ),
      );
    });
  });
}
