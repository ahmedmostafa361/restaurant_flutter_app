import 'package:json_annotation/json_annotation.dart';

import 'order_item_request_dto.dart';

part 'make_order_request_dto.g.dart';

@JsonSerializable()
class MakeOrderRequestDto {
  @JsonKey(name: "menuDTO")
  final List<OrderItemRequestDto> menuDTO;

  MakeOrderRequestDto({
    required this.menuDTO,
  });

  factory MakeOrderRequestDto.fromJson(Map<String, dynamic> json) {
    return _$MakeOrderRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MakeOrderRequestDtoToJson(this);
  }
}