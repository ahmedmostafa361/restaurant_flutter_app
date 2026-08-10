import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_order.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/order_details.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/cubit/order_details_screen_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/cubit/order_details_screen_view_model.dart';

import '../../../../../helpers/mock_classes.dart';

void main() {
  late MockGetOrderDetailsUseCase mockGetOrderDetailsUseCase;
  late MockAuthLocalStorage mockAuthLocalStorage;
  late MockDeleteOrderUseCase mockDeleteOrderUseCase;

  setUp(() {
    mockGetOrderDetailsUseCase = MockGetOrderDetailsUseCase();
    mockAuthLocalStorage = MockAuthLocalStorage();
    mockDeleteOrderUseCase = MockDeleteOrderUseCase();
  });

  final lineItems = [
    OrderDetails(
      orderID: 215,
      userID: 'ahmed@bachelor.com',
      itemName: 'Chicken Biryani',
      quantity: 2,
      itemPrice: 280.0,
      totalPrice: 560.0,
      masterID: 150,
    ),
  ];

  group('OrderDetailsScreenViewModel — getOrderDetails', () {
    blocTest<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
      'emits [Loading, Success] with line items on success',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockGetOrderDetailsUseCase.invoke(150, any()))
            .thenAnswer((_) async => lineItems);
        return OrderDetailsScreenViewModel(
          mockGetOrderDetailsUseCase,
          mockAuthLocalStorage,
          mockDeleteOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrderDetails(150),
      expect: () =>
      [
        isA<OrderDetailsScreenLoadingState>(),
        isA<OrderDetailsScreenSuccessState>()
            .having((s) => s.orderDetails.length, 'orderDetails.length', 1),
      ],
    );

    blocTest<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
      'emits Error when apikey is missing, without calling the use case',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode()).thenAnswer((
            _) async => null);
        return OrderDetailsScreenViewModel(
          mockGetOrderDetailsUseCase,
          mockAuthLocalStorage,
          mockDeleteOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrderDetails(150),
      expect: () =>
      [
        isA<OrderDetailsScreenErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Please log in again.'),
      ],
      verify: (_) {
        verifyNever(() => mockGetOrderDetailsUseCase.invoke(any(), any()));
      },
    );

    blocTest<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
      'emits [Loading, Error] when the use case throws',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockGetOrderDetailsUseCase.invoke(150, any()))
            .thenThrow(ServerErrorException(errorMessage: 'Order not found'));
        return OrderDetailsScreenViewModel(
          mockGetOrderDetailsUseCase,
          mockAuthLocalStorage,
          mockDeleteOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrderDetails(150),
      expect: () =>
      [
        isA<OrderDetailsScreenLoadingState>(),
        isA<OrderDetailsScreenErrorState>()
            .having((s) => s.errorMessage, 'errorMessage', 'Order not found'),
      ],
    );
  });

  group('OrderDetailsScreenViewModel — deleteOrderItem', () {
    blocTest<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
      'emits DeleteSuccessState with the deleted order id on success',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockDeleteOrderUseCase.invoke(215, any())).thenAnswer(
              (_) async =>
              DeleteOrder(message: 'Order deleted', orderExists: null),
        );
        return OrderDetailsScreenViewModel(
          mockGetOrderDetailsUseCase,
          mockAuthLocalStorage,
          mockDeleteOrderUseCase,
        );
      },
      act: (cubit) => cubit.deleteOrderItem(215),
      expect: () =>
      [
        isA<OrderDetailsScreenDeleteSuccessState>()
            .having((s) => s.deletedOrderId, 'deletedOrderId', 215),
      ],
      verify: (_) {
        verify(() =>
            mockDeleteOrderUseCase.invoke(
                215, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9'))
            .called(1);
      },
    );

    blocTest<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
      'emits Error when apikey is missing, without calling the use case',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode()).thenAnswer((
            _) async => null);
        return OrderDetailsScreenViewModel(
          mockGetOrderDetailsUseCase,
          mockAuthLocalStorage,
          mockDeleteOrderUseCase,
        );
      },
      act: (cubit) => cubit.deleteOrderItem(215),
      expect: () =>
      [
        isA<OrderDetailsScreenErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Please log in again.'),
      ],
      verify: (_) {
        verifyNever(() => mockDeleteOrderUseCase.invoke(any(), any()));
      },
    );

    blocTest<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
      'emits Error when delete fails on the server',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockDeleteOrderUseCase.invoke(215, any()))
            .thenThrow(ServerErrorException(errorMessage: 'Delete failed'));
        return OrderDetailsScreenViewModel(
          mockGetOrderDetailsUseCase,
          mockAuthLocalStorage,
          mockDeleteOrderUseCase,
        );
      },
      act: (cubit) => cubit.deleteOrderItem(215),
      expect: () =>
      [
        isA<OrderDetailsScreenErrorState>()
            .having((s) => s.errorMessage, 'errorMessage', 'Delete failed'),
      ],
    );
  });
}