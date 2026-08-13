import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

class MasterOrderExists {
  final int? masterID;
  final String? userID;
  final Restaurant? restaurant;
  final int? restaurantID;
  final double? grandTotal;

  MasterOrderExists({
    this.masterID,
    this.userID,
    this.restaurant,
    this.restaurantID,
    this.grandTotal,
  });
}
