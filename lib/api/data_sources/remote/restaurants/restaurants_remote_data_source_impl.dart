import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/api/api_services.dart';
import 'package:restaurant_flutter_app/api/mappers/restaurants/restaurant_mappers.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/restaurants_remote_data_source.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

import '../../../dio/dio_exceptions/app_exceptions.dart';

@Injectable(as: RestaurantsRemoteDataSource)
class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
  final ApiServices apiServices;
  RestaurantsRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      var restaurantsResponse = await apiServices.getRestaurants();
      return restaurantsResponse.map((dto) => dto.toDomain()).toList();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}