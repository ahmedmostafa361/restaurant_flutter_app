import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/repository/restaurants/restaurants_repository.dart';

import '../entinties/response/restaurants/restaurant.dart';

@injectable
class GetAllRestaurantsUseCase {
  RestaurantsRepository restaurantsRepository;
  GetAllRestaurantsUseCase(this.restaurantsRepository);
  Future<List<Restaurant>> invoke() {
    return restaurantsRepository.getRestaurants();
  }
}