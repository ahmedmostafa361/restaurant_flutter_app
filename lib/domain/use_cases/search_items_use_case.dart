import '../entinties/response/menu/menu_item.dart';
import '../repository/menu/menu_items_repository.dart';

class SearchItemsUseCase {
  ItemsRepository itemsRepository;

  SearchItemsUseCase(this.itemsRepository);

  Future<List<MenuItem>> invoke({String? itemName}) {
    return itemsRepository.searchItems(itemName);
  }
}
