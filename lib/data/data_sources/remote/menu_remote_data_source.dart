import '../../../domain/entinties/response/menu/menu_response.dart';

abstract class MenuRemoteDataSource {
  Future<List<MenuResponse>> getMenu(int restaurantId, String? sortByPrice);
}