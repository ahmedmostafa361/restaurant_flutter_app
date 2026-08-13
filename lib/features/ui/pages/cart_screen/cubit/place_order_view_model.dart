import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/auth_local_storage.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';
import 'package:restaurant_flutter_app/domain/use_cases/place_order_use_case.dart';

import '../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import 'place_order_states.dart';

@injectable
class PlaceOrderViewModel extends Cubit<PlaceOrderStates> {
  final PlaceOrderUseCase placeOrderUseCase;
  final AuthLocalStorage authLocalStorage;

  PlaceOrderViewModel(this.placeOrderUseCase, this.authLocalStorage)
    : super(PlaceOrderInitialState());

  Future<void> placeOrder(MakeOrderRequest request) async {
    emit(PlaceOrderLoadingState());
    try {
      final apiKey = await authLocalStorage.getUserCode();
      if (apiKey == null || apiKey.trim().isEmpty) {
        emit(
          PlaceOrderErrorState(
            errorMessage: "You need to be signed in to place an order.",
          ),
        );
        return;
      }

      final response = await placeOrderUseCase.invoke(request, apiKey);
      emit(PlaceOrderSuccessState(response: response));
    } on ServerErrorException catch (e) {
      emit(PlaceOrderErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(
        PlaceOrderErrorState(
          errorMessage: "Something went wrong, please try again.",
        ),
      );
    }
  }
}
