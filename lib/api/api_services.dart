import 'package:dio/dio.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import 'end_points.dart';
import 'model/response/restaurants/restaurant_dto.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {
    String? baseUrl,
  }) = _ApiServices;

  @GET(EndPoints.restaurantApi)
  Future<List<RestaurantDto>> getRestaurants();

  @GET(EndPoints.restaurantByIdApi)
  Future<RestaurantDto> getRestaurantById(@Path("id") int id);

  @GET(EndPoints.menuApi)
  Future<List<MenuResponseDto>> getMenu(@Path("id") int id,
      @Query("sortbyprice") String? sortByPrice,);
}