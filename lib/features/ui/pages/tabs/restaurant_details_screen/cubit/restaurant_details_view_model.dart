import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_by_id_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_menu_use_case.dart';

import '../../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import 'restaurant_details_states.dart';

@injectable
class RestaurantDetailsViewModel extends Cubit<RestaurantDetailsStates> {
  final GetRestaurantByIdUseCase getRestaurantByIdUseCase;
  final GetRestaurantMenuUseCase getRestaurantMenuUseCase;

  RestaurantDetailsViewModel(this.getRestaurantByIdUseCase,
      this.getRestaurantMenuUseCase,) : super(RestaurantDetailsInitialState());

  Future<void> getRestaurantDetails(int restaurantId,
      {String? sortByPrice}) async {
    emit(RestaurantDetailsLoadingState());
    try {
      final results = await Future.wait([
        getRestaurantByIdUseCase.invoke(restaurantId),
        getRestaurantMenuUseCase.invoke(restaurantId, sortByPrice: sortByPrice),
      ]);

      emit(RestaurantDetailsSuccessState(
        restaurant: results[0] as dynamic,
        menu: results[1] as dynamic,
      ));
    } on ServerErrorException catch (e) {
      emit(RestaurantDetailsErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(RestaurantDetailsErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }

  // Called when the user flips the sort dropdown/toggle on the menu.
  // Re-fetches only the menu, keeps the restaurant info already on screen.
  Future<void> resortMenu(int restaurantId, String? sortByPrice) async {
    final currentState = state;
    if (currentState is! RestaurantDetailsSuccessState &&
        currentState is! MenuSortingState) {
      return; // nothing to re-sort yet, ignore
    }

    final restaurant = currentState is RestaurantDetailsSuccessState
        ? currentState.restaurant
        : (currentState as MenuSortingState).restaurant;

    try {
      final menu = await getRestaurantMenuUseCase.invoke(
          restaurantId, sortByPrice: sortByPrice);
      emit(MenuSortingState(restaurant: restaurant, menu: menu));
    } on ServerErrorException catch (e) {
      emit(RestaurantDetailsErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(RestaurantDetailsErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }
}