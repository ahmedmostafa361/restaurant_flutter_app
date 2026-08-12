import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/data_sources/remote/orders/orders_remote_data_source_impl.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_order.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/master_order.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/order_details.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/order_history_details.dart';

import '../../../helpers/mock_classes.dart';

class FakeMakeOrderRequest extends Fake implements MakeOrderRequest {}

void main() {
  late MockOrdersRemoteDataSource mockRemoteDataSource;
  late OrdersRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeMakeOrderRequest());
  });

  setUp(() {
    mockRemoteDataSource = MockOrdersRemoteDataSource();
    repository = OrdersRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('OrdersRepositoryImpl', () {
    test(
        'makeOrder delegates with request and apikey, returns its result', () async {
      final request = MakeOrderRequest(restaurantId: 4, items: []);
      final response = MakeOrderResponse(fullOrder: [], grandTotal: 560.0);
      when(() => mockRemoteDataSource.makeOrder(request, 'apikey123'))
          .thenAnswer((_) async => response);

      final result = await repository.makeOrder(request, 'apikey123');

      expect(result, response);
      verify(() => mockRemoteDataSource.makeOrder(request, 'apikey123')).called(
          1);
    });

    test('getAllOrders delegates with apikey, returns its result', () async {
      final orders = [
        OrderDetailsHistory(masterID: 150,
            userID: 'ahmed@bachelor.com',
            restaurantID: 4,
            grandTotal: 560.0),
      ];
      when(() => mockRemoteDataSource.getAllOrders('apikey123')).thenAnswer((
          _) async => orders);

      final result = await repository.getAllOrders('apikey123');

      expect(result, orders);
      verify(() => mockRemoteDataSource.getAllOrders('apikey123')).called(1);
    });

    test(
        'getOrderDetailsById delegates with masterId and apikey, returns its result', () async {
      final lineItems = [
        OrderDetails(orderID: 215,
            itemName: 'Chicken Biryani',
            quantity: 2,
            itemPrice: 280.0,
            masterID: 150),
      ];
      when(() => mockRemoteDataSource.getOrderDetailsById(150, 'apikey123'))
          .thenAnswer((_) async => lineItems);

      final result = await repository.getOrderDetailsById(150, 'apikey123');

      expect(result, lineItems);
      verify(() => mockRemoteDataSource.getOrderDetailsById(150, 'apikey123'))
          .called(1);
    });

    test(
        'deleteSingleOrderById delegates with orderId and apikey, returns its result', () async {
      final deleteResult = DeleteOrder(
          message: 'Order deleted', orderExists: null);
      when(() => mockRemoteDataSource.deleteSingleOrderById(215, 'apikey123'))
          .thenAnswer((_) async => deleteResult);

      final result = await repository.deleteSingleOrderById(215, 'apikey123');

      expect(result, deleteResult);
      verify(() => mockRemoteDataSource.deleteSingleOrderById(215, 'apikey123'))
          .called(1);
    });

    test(
        'propagates exceptions from the remote data source unchanged', () async {
      when(() => mockRemoteDataSource.getAllOrders('apikey123')).thenThrow(
          Exception('server down'));

      expect(() => repository.getAllOrders('apikey123'), throwsException);
    });
  });
}