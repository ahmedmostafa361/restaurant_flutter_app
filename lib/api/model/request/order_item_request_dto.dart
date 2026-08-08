import 'package:json_annotation/json_annotation.dart';

part 'order_item_request_dto.g.dart';

@JsonSerializable()
class OrderItemRequestDto {
  @JsonKey(name: "itemName")
  final String itemName;
  @JsonKey(name: "quantity")
  final int quantity;

  OrderItemRequestDto({
    required this.itemName,
    required this.quantity,
  });

  factory OrderItemRequestDto.fromJson(Map<String, dynamic> json) {
    return _$OrderItemRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemRequestDtoToJson(this);
  }
}