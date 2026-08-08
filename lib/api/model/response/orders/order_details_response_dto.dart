import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_flutter_app/api/model/response/auth/user_response_dto.dart';

part 'order_details_response_dto.g.dart';

@JsonSerializable()
class OrderDetailsResponseDto {
  @JsonKey(name: "orderID")
  final int? orderID;
  @JsonKey(name: "user")
  final UserResponseDto? user;
  @JsonKey(name: "userID")
  final String? userID;
  @JsonKey(name: "itemName")
  final String? itemName;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "itemPrice")
  final double? itemPrice;
  @JsonKey(name: "totalPrice")
  final double? totalPrice;
  @JsonKey(name: "masterID")
  final int? masterID;

  OrderDetailsResponseDto({
    this.orderID,
    this.user,
    this.userID,
    this.itemName,
    this.quantity,
    this.itemPrice,
    this.totalPrice,
    this.masterID,
  });

  factory OrderDetailsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$OrderDetailsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderDetailsResponseDtoToJson(this);
  }
}
