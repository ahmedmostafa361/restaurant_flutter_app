import '../../entinties/response/restaurants/restaurant.dart';

abstract class RestaurantsRepository {
  Future<List<Restaurant>> getRestaurants();
}