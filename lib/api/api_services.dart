import 'package:dio/dio.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_item_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/menu/menu_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import 'end_points.dart';
import 'model/request/make_order_request_dto.dart';
import 'model/request/register_request_dto.dart';
import 'model/response/auth/user_code_login_response_dto.dart';
import 'model/response/orders/make_order_response_dto.dart';
import 'model/response/orders/order_history_dto.dart';
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

  @GET(EndPoints.restaurantItemApi)
  Future<List<MenuItemDto>> getRestaurantItems(
      @Query("ItemName") String? searchByName,);

  @POST(EndPoints.registerRequestApi)
  Future<UserResponseDto> register(@Body() RegisterRequestDto registerRequest,);

  @GET(EndPoints.loginRequestApi)
  Future<LoginResponseDto> login(@Query("UserEmail") String email,
      @Query("Password") String password,);

  @POST(EndPoints.makeOrderApi)
  Future<MakeOrderResponseDto> makeOrder(@Path("restaurantId") int restaurantId,
      @Query("apikey") String apikey,
      @Body() MakeOrderRequestDto request,);

  @GET(EndPoints.getAllOrderApi)
  Future<List<OrderDetailsHistoryDto>> getAllOrders(
      @Query("apikey") String apikey,);

  @GET(EndPoints.getAllOrderDetailsByIdApi)
  Future<List<OrderDetailsResponseDto>> getAllOrdersDetailsById(
      @Path("master_id") int masterId,
      @Query("apikey") String apikey,);
}
