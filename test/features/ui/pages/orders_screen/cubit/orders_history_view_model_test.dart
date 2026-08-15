import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_master_order.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/order_history_details.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/cubit/orders_history_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/cubit/orders_history_view_model.dart';

import '../../../../../helpers/mock_classes.dart';

void main() {
  late MockGetOrdersUseCase mockGetOrdersUseCase;
  late MockAuthLocalStorage mockAuthLocalStorage;
  late MockDeleteMasterOrderUseCase mockDeleteMasterOrderUseCase;

  setUp(() {
    mockGetOrdersUseCase = MockGetOrdersUseCase();
    mockAuthLocalStorage = MockAuthLocalStorage();
    mockDeleteMasterOrderUseCase = MockDeleteMasterOrderUseCase();
  });

  final orders = [
    OrderDetailsHistory(
      masterID: 150,
      userID: 'ahmed@bachelor.com',
      userCode: 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
      restaurantID: 4,
      grandTotal: 560.0,
    ),
  ];

  group('OrdersHistoryViewModel — getOrders', () {
    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits NotAuthenticatedState when apikey is null, without calling the use case',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode()).thenAnswer((
            _) async => null);
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrders(),
      expect: () => [isA<OrdersHistoryNotAuthenticatedState>()],
      verify: (_) {
        verifyNever(() => mockGetOrdersUseCase.invoke(any()));
      },
    );

    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits [Loading, Empty] when there are no orders',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockGetOrdersUseCase.invoke(any())).thenAnswer((_) async =>
        [
        ]);
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrders(),
      expect: () =>
      [
        isA<OrdersHistoryLoadingState>(),
        isA<OrdersHistoryEmptyState>(),
      ],
    );

    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits [Loading, Success] when orders exist',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockGetOrdersUseCase.invoke(any())).thenAnswer((
            _) async => orders);
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrders(),
      expect: () =>
      [
        isA<OrdersHistoryLoadingState>(),
        isA<OrdersHistorySuccessState>()
            .having((s) => s.orders.length, 'orders.length', 1)
            .having((s) => s.orders.first.masterID, 'masterID', 150),
      ],
      verify: (_) {
        verify(() =>
            mockGetOrdersUseCase.invoke('df96c4c0-c4d2-4614-9c3d-c493fb05c7f9'))
            .called(1);
      },
    );

    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits [Loading, Error] when the use case throws',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockGetOrdersUseCase.invoke(any()))
            .thenThrow(
            ServerErrorException(errorMessage: 'Failed to load orders'));
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.getOrders(),
      expect: () =>
      [
        isA<OrdersHistoryLoadingState>(),
        isA<OrdersHistoryErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Failed to load orders'),
      ],
    );
  });

  group('OrdersHistoryViewModel — deleteMasterOrder', () {
    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits DeleteSuccessState with the deleted masterId on success',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockDeleteMasterOrderUseCase.invoke(150, any())).thenAnswer(
              (_) async =>
              DeleteMasterOrder(
              message: 'Deleted', orderExists: [], singleOrders: []),
        );
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.deleteMasterOrder(150),
      expect: () =>
      [
        isA<OrdersHistoryDeleteSuccessState>()
            .having((s) => s.deletedMasterId, 'deletedMasterId', 150),
      ],
      verify: (_) {
        verify(() =>
            mockDeleteMasterOrderUseCase.invoke(
            150, 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9'))
            .called(1);
      },
    );

    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits Error when apikey is missing, without calling the use case',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode()).thenAnswer((
            _) async => null);
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.deleteMasterOrder(150),
      expect: () =>
      [
        isA<OrdersHistoryErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Please log in again.'),
      ],
      verify: (_) {
        verifyNever(() => mockDeleteMasterOrderUseCase.invoke(any(), any()));
      },
    );

    blocTest<OrdersHistoryViewModel, OrdersHistoryStates>(
      'emits Error when the use case throws',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockDeleteMasterOrderUseCase.invoke(150, any()))
            .thenThrow(ServerErrorException(errorMessage: 'Delete failed'));
        return OrdersHistoryViewModel(
          mockGetOrdersUseCase,
          mockAuthLocalStorage,
          mockDeleteMasterOrderUseCase,
        );
      },
      act: (cubit) => cubit.deleteMasterOrder(150),
      expect: () =>
      [
        isA<OrdersHistoryErrorState>()
            .having((s) => s.errorMessage, 'errorMessage', 'Delete failed'),
      ],
    );
  });
}