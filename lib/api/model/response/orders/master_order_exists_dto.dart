import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:restaurant_flutter_app/api/model/response/restaurants/restaurant_dto.dart';

part 'master_order_exists_dto.g.dart';

@JsonSerializable()
class MasterOrderExistsDto {
  @JsonKey(name: "masterID")
  final int? masterID;
  @JsonKey(name: "user")
  final UserResponseDto? user;
  @JsonKey(name: "userID")
  final String? userID;
  @JsonKey(name: "restaurant")
  final RestaurantDto? restaurant;
  @JsonKey(name: "restaurantID")
  final int? restaurantID;
  @JsonKey(name: "grandTotal")
  final double? grandTotal;

  MasterOrderExistsDto({
    this.masterID,
    this.user,
    this.userID,
    this.restaurant,
    this.restaurantID,
    this.grandTotal,
  });

  factory MasterOrderExistsDto.fromJson(Map<String, dynamic> json) {
    return _$MasterOrderExistsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MasterOrderExistsDtoToJson(this);
  }
}
