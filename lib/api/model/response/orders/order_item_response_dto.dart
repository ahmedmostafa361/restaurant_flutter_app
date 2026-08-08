import 'package:json_annotation/json_annotation.dart';

part 'order_item_response_dto.g.dart';

@JsonSerializable()
class OrderItemResponseDto {
  @JsonKey(name: "orderID")
  final int? orderID;
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

  OrderItemResponseDto({
    this.orderID,
    this.userID,
    this.itemName,
    this.quantity,
    this.itemPrice,
    this.totalPrice,
    this.masterID,
  });

  factory OrderItemResponseDto.fromJson(Map<String, dynamic> json) {
    return _$OrderItemResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemResponseDtoToJson(this);
  }
}