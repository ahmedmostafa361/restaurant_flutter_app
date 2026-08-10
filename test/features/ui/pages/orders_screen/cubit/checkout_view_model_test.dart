import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/cart_item.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/master_order.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/cubit/orders_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/cubit/orders_view_model.dart';

import '../../../../../helpers/mock_classes.dart';

class FakeMakeOrderRequest extends Fake implements MakeOrderRequest {}

void main() {
  late MockPlaceOrderUseCase mockPlaceOrderUseCase;
  late MockAuthLocalStorage mockAuthLocalStorage;

  setUpAll(() {
    registerFallbackValue(FakeMakeOrderRequest());
  });

  setUp(() {
    mockPlaceOrderUseCase = MockPlaceOrderUseCase();
    mockAuthLocalStorage = MockAuthLocalStorage();
  });

  final cartItems = [
    CartItem(itemName: 'Chicken Biryani', itemPrice: 280, quantity: 2),
  ];

  group('CheckoutViewModel', () {
    blocTest<CheckoutViewModel, CheckoutStates>(
      'emits Error immediately when cart is empty, without calling API or checking apikey',
      build: () =>
          CheckoutViewModel(mockPlaceOrderUseCase, mockAuthLocalStorage),
      act: (cubit) => cubit.placeOrder(restaurantId: 4, cartItems: []),
      expect: () =>
      [
        isA<CheckoutErrorState>().having((s) => s.errorMessage, 'errorMessage',
            'Your cart is empty.'),
      ],
      verify: (_) {
        verifyNever(() => mockAuthLocalStorage.getUserCode());
        verifyNever(() => mockPlaceOrderUseCase.invoke(any(), any()));
      },
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'emits NotAuthenticatedState when apikey is null',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode()).thenAnswer((
            _) async => null);
        return CheckoutViewModel(mockPlaceOrderUseCase, mockAuthLocalStorage);
      },
      act: (cubit) => cubit.placeOrder(restaurantId: 4, cartItems: cartItems),
      expect: () => [isA<CheckoutNotAuthenticatedState>()],
      verify: (_) {
        verifyNever(() => mockPlaceOrderUseCase.invoke(any(), any()));
      },
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'emits NotAuthenticatedState when apikey is an empty string',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode()).thenAnswer((
            _) async => '');
        return CheckoutViewModel(mockPlaceOrderUseCase, mockAuthLocalStorage);
      },
      act: (cubit) => cubit.placeOrder(restaurantId: 4, cartItems: cartItems),
      expect: () => [isA<CheckoutNotAuthenticatedState>()],
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'emits [Loading, Success] on a valid order',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockPlaceOrderUseCase.invoke(any(), any())).thenAnswer(
              (_) async => MakeOrderResponse(fullOrder: [], grandTotal: 560.0),
        );
        return CheckoutViewModel(mockPlaceOrderUseCase, mockAuthLocalStorage);
      },
      act: (cubit) => cubit.placeOrder(restaurantId: 4, cartItems: cartItems),
      expect: () =>
      [
        isA<CheckoutLoadingState>(),
        isA<CheckoutSuccessState>()
            .having((s) => s.orderResult.grandTotal, 'grandTotal', 560.0),
      ],
      verify: (_) {
        verify(() =>
            mockPlaceOrderUseCase.invoke(
              any(),
              'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9',
            )).called(1);
      },
    );

    blocTest<CheckoutViewModel, CheckoutStates>(
      'emits [Loading, Error] when the use case throws ServerErrorException',
      build: () {
        when(() => mockAuthLocalStorage.getUserCode())
            .thenAnswer((_) async => 'df96c4c0-c4d2-4614-9c3d-c493fb05c7f9');
        when(() => mockPlaceOrderUseCase.invoke(any(), any()))
            .thenThrow(ServerErrorException(errorMessage: 'Order failed'));
        return CheckoutViewModel(mockPlaceOrderUseCase, mockAuthLocalStorage);
      },
      act: (cubit) => cubit.placeOrder(restaurantId: 4, cartItems: cartItems),
      expect: () =>
      [
        isA<CheckoutLoadingState>(),
        isA<CheckoutErrorState>().having((s) => s.errorMessage, 'errorMessage',
            'Order failed'),
      ],
    );
  });
}