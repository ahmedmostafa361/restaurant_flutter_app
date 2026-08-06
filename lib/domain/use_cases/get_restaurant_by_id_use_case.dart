import 'package:restaurant_flutter_app/domain/repository/restaurants/restaurants_repository.dart';

import '../entinties/response/restaurants/restaurant.dart';

class GetRestaurantByIdUseCase {
  RestaurantsRepository restaurantsRepository;

  GetRestaurantByIdUseCase(this.restaurantsRepository);

  Future<Restaurant> invoke(int id) {
    return restaurantsRepository.getRestaurantById(id);
  }
}