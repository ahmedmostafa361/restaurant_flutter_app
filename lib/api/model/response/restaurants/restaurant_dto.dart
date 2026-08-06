import 'package:json_annotation/json_annotation.dart';

part 'restaurant_dto.g.dart';

@JsonSerializable()
class RestaurantDto {
  @JsonKey(name: "restaurantID")
  final int? restaurantID;
  @JsonKey(name: "restaurantName")
  final String? restaurantName;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "parkingLot")
  final bool? parkingLot;

  RestaurantDto ({
    this.restaurantID,
    this.restaurantName,
    this.address,
    this.type,
    this.parkingLot,
  });

  factory RestaurantDto.fromJson(Map<String, dynamic> json) {
    return _$RestaurantDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RestaurantDtoToJson(this);
  }
}


