import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

import '../../../domain/repository/restaurants/restaurants_repository.dart';
import '../../data_sources/remote/restaurants_remote_data_source.dart';

@Injectable(as: RestaurantsRepository)
class RestaurantsRepositoryImpl implements RestaurantsRepository {
  final RestaurantsRemoteDataSource remoteDataSource;

  RestaurantsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Restaurant>> getRestaurants() {
    return remoteDataSource.getRestaurants();
  }
}
