import '../../entinties/response/menu/menu_item.dart';

abstract class ItemsRepository {
  Future<List<MenuItem>> searchItems(String? itemName);
}
