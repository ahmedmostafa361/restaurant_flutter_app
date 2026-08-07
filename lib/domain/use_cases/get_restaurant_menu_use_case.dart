import 'package:restaurant_flutter_app/domain/repository/menu/menu_repository.dart';

import '../entinties/response/menu/menu_response.dart';

class GetRestaurantMenuUseCase {
  MenuRepository menuRepository;

  GetRestaurantMenuUseCase(this.menuRepository);

  Future<List<MenuResponse>> invoke(int restaurantId, {String? sortByPrice}) {
    return menuRepository.getMenu(restaurantId, sortByPrice);
  }
}