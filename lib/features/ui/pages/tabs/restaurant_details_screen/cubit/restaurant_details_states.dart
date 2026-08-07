import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

abstract class RestaurantDetailsStates {}

class RestaurantDetailsInitialState extends RestaurantDetailsStates {}

class RestaurantDetailsLoadingState extends RestaurantDetailsStates {}

class RestaurantDetailsSuccessState extends RestaurantDetailsStates {
  final Restaurant restaurant;
  final List<MenuResponse> menu;

  RestaurantDetailsSuccessState({required this.restaurant, required this.menu});
}

class RestaurantDetailsErrorState extends RestaurantDetailsStates {
  final String errorMessage;
  RestaurantDetailsErrorState({required this.errorMessage});
}

// Separate, lightweight state for re-sorting the menu without
// re-fetching restaurant details or showing a full-screen loader again
class MenuSortingState extends RestaurantDetailsStates {
  final Restaurant restaurant;
  final List<MenuResponse> menu;

  MenuSortingState({required this.restaurant, required this.menu});
}