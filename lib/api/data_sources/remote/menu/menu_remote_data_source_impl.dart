import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';

import '../../../../data/data_sources/remote/menu_remote_data_source.dart';
import '../../../../domain/repository/menu/menu_repository.dart';

@Injectable(as: MenuRepository)
class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;

  MenuRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MenuResponse>> getMenu(int restaurantId, String? sortByPrice) {
    return remoteDataSource.getMenu(restaurantId, sortByPrice);
  }
}