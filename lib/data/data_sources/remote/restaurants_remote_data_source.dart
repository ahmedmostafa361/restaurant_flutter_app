import '../../../domain/entinties/response/restaurants/restaurant.dart';

abstract class RestaurantsRemoteDataSource {
  Future<List<Restaurant>> getRestaurants();
}