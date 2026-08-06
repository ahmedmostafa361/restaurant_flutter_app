import 'package:restaurant_flutter_app/api/model/response/restaurants/restaurant_dto.dart';

import '../../../domain/entinties/response/restaurants/restaurant.dart';

extension RestaurantMappers on RestaurantDto{
  Restaurant toDomain() {
    return Restaurant(
      restaurantID: restaurantID,
      restaurantName: restaurantName,
      address: address,
      type: type,
      parkingLot: parkingLot,
    );
  }
}

