import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

abstract class HomeScreenStates {}

class HomeScreenInitialState extends HomeScreenStates {}

class HomeScreenLoadingState extends HomeScreenStates {}

class HomeScreenSuccessState extends HomeScreenStates {
  final List<Restaurant> restaurants;
  HomeScreenSuccessState({required this.restaurants});
}

class HomeScreenErrorState extends HomeScreenStates {
  final String errorMessage;
  HomeScreenErrorState({required this.errorMessage});
}