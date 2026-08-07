import '../../entinties/response/menu/menu_response.dart';

abstract class MenuRepository {
  Future<List<MenuResponse>> getMenu(int restaurantId, String? sortByPrice);
}