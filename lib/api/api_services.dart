import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'end_points.dart';
import 'model/response/restaurants/restaurant_dto.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {
    String? baseUrl,
  }) = _ApiServices;

  // Moved inside the ApiServices class
  @GET(EndPoints.restaurantApi)
  Future<List<RestaurantDto>> getRestaurants();
}