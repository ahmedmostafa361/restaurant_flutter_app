import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

abstract class RestaurantDetailsStates {}

class RestaurantDetailsInitialState extends RestaurantDetailsStates {}

class RestaurantDetailsLoadingState extends RestaurantDetailsStates {}

class RestaurantDetailsSuccessState extends RestaurantDetailsStates {
  final Restaurant restaurant;

  RestaurantDetailsSuccessState({required this.restaurant});
}

class RestaurantDetailsErrorState extends RestaurantDetailsStates {
  final String errorMessage;

  RestaurantDetailsErrorState({required this.errorMessage});
}