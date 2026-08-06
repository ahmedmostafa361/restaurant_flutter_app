import '../../entinties/response/restaurants/restaurant.dart';

abstract class RestaurantsRepository {
  Future<List<Restaurant>> getRestaurants();

  Future<Restaurant> getRestaurantById(int id);
}