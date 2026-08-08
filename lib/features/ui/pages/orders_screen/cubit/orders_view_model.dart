import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/auth_local_storage.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/order_item_request.dart';
import 'package:restaurant_flutter_app/domain/use_cases/place_order_use_case.dart';

import '../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import '../../../../../domain/entinties/request/cart_item.dart';
import 'orders_states.dart';

@injectable
class CheckoutViewModel extends Cubit<CheckoutStates> {
  final PlaceOrderUseCase placeOrderUseCase;
  final AuthLocalStorage authLocalStorage;

  CheckoutViewModel(this.placeOrderUseCase, this.authLocalStorage)
      : super(CheckoutInitialState());

  Future<void> placeOrder({
    required int restaurantId,
    required List<CartItem> cartItems,
  }) async {
    if (cartItems.isEmpty) {
      emit(CheckoutErrorState(errorMessage: "Your cart is empty."));
      return;
    }

    final apikey = await authLocalStorage.getUserCode();
    if (apikey == null || apikey
        .trim()
        .isEmpty) {
      emit(CheckoutNotAuthenticatedState());
      return;
    }

    emit(CheckoutLoadingState());
    try {
      final request = MakeOrderRequest(
        restaurantId: restaurantId,
        items: cartItems
            .map((item) =>
            OrderItemRequest(itemName: item.itemName, quantity: item.quantity))
            .toList(),
      );

      final result = await placeOrderUseCase.invoke(request, apikey);
      emit(CheckoutSuccessState(orderResult: result));
    } on ServerErrorException catch (e) {
      emit(CheckoutErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(CheckoutErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }
}