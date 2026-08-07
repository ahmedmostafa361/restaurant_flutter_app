import '../../../domain/entinties/response/menu/menu_item.dart';

abstract class ItemsRemoteDataSource {
  Future<List<MenuItem>> searchItems(String? itemName);
}