import 'package:injectable/injectable.dart';

import '../../../../data/data_sources/remote/items_remote_data_source.dart';
import '../../../../domain/entinties/response/menu/menu_item.dart';
import '../../../../domain/repository/menu/menu_items_repository.dart';

@Injectable(as: ItemsRepository)
class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsRemoteDataSource remoteDataSource;

  ItemsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MenuItem>> searchItems(String? itemName) {
    return remoteDataSource.searchItems(itemName);
  }
}
