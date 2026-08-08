import 'package:json_annotation/json_annotation.dart';

import 'order_item_response_dto.dart';

part 'make_order_response_dto.g.dart';

@JsonSerializable()
class MakeOrderResponseDto {
  @JsonKey(name: "fullorder")
  final List<OrderItemResponseDto>? fullOrder;
  @JsonKey(name: "grandTotal")
  final double? grandTotal;

  MakeOrderResponseDto({
    this.fullOrder,
    this.grandTotal,
  });

  factory MakeOrderResponseDto.fromJson(Map<String, dynamic> json) {
    return _$MakeOrderResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MakeOrderResponseDtoToJson(this);
  }
}