import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/auth_local_storage.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_order_details_use_case.dart';

import '../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import '../../../../../domain/use_cases/delete_order_use_case.dart';
import 'order_details_screen_states.dart';

@injectable
class OrderDetailsScreenViewModel extends Cubit<OrderDetailsScreenStates> {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final AuthLocalStorage authLocalStorage;
  final DeleteOrderUseCase deleteOrderUseCase;

  OrderDetailsScreenViewModel(
    this.getOrderDetailsUseCase,
    this.authLocalStorage,
      this.deleteOrderUseCase,
  ) : super(OrderDetailsScreenInitialState());

  Future<void> getOrderDetails(int masterId) async {
    final apikey = await authLocalStorage.getUserCode();
    if (apikey == null || apikey.trim().isEmpty) {
      emit(OrderDetailsScreenErrorState(errorMessage: "Please log in again."));
      return;
    }

    emit(OrderDetailsScreenLoadingState());
    try {
      final orderDetails = await getOrderDetailsUseCase.invoke(
        masterId,
        apikey,
      );
      emit(OrderDetailsScreenSuccessState(orderDetails: orderDetails));
    } on ServerErrorException catch (e) {
      emit(OrderDetailsScreenErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(
        OrderDetailsScreenErrorState(
          errorMessage: "Something went wrong, please try again.",
        ),
      );
    }
  }

  Future<void> deleteOrderItem(int orderId) async {
    final apikey = await authLocalStorage.getUserCode();
    if (apikey == null || apikey
        .trim()
        .isEmpty) {
      emit(OrderDetailsScreenErrorState(errorMessage: "Please log in again."));
      return;
    }

    try {
      await deleteOrderUseCase.invoke(orderId, apikey);
      emit(OrderDetailsScreenDeleteSuccessState(deletedOrderId: orderId));
    } on ServerErrorException catch (e) {
      emit(OrderDetailsScreenErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(OrderDetailsScreenErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }
}
