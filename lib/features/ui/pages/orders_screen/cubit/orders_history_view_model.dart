import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/auth_local_storage.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_orders_history_use_case.dart';

import '../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import '../../../../../domain/use_cases/delete_master_order_use_case.dart';
import 'orders_history_states.dart';

@injectable
class OrdersHistoryViewModel extends Cubit<OrdersHistoryStates> {
  final GetOrdersUseCase getOrdersUseCase;
  final AuthLocalStorage authLocalStorage;
  final DeleteMasterOrderUseCase deleteMasterOrderUseCase;


  OrdersHistoryViewModel(this.getOrdersUseCase, this.authLocalStorage,
      this.deleteMasterOrderUseCase)
      : super(OrdersHistoryInitialState());


  Future<void> deleteMasterOrder(int masterId) async {
    final apikey = await authLocalStorage.getUserCode();
    if (apikey == null || apikey
        .trim()
        .isEmpty) {
      emit(OrdersHistoryErrorState(errorMessage: "Please log in again."));
      return;
    }

    try {
      await deleteMasterOrderUseCase.invoke(masterId, apikey);
      emit(OrdersHistoryDeleteSuccessState(deletedMasterId: masterId));
    } on ServerErrorException catch (e) {
      emit(OrdersHistoryErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(OrdersHistoryErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }
  Future<void> getOrders() async {
    final apikey = await authLocalStorage.getUserCode();
    if (apikey == null || apikey
        .trim()
        .isEmpty) {
      emit(OrdersHistoryNotAuthenticatedState());
      return;
    }

    emit(OrdersHistoryLoadingState());
    try {
      final orders = await getOrdersUseCase.invoke(apikey);
      if (orders.isEmpty) {
        emit(OrdersHistoryEmptyState());
      } else {
        emit(OrdersHistorySuccessState(orders: orders));
      }
    } on ServerErrorException catch (e) {
      emit(OrdersHistoryErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(OrdersHistoryErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }
}