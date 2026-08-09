import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';

part 'delete_order_dto.g.dart';

@JsonSerializable()
class DeleteOrderDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "orderexits")
  final OrderDetailsResponseDto? orderExists;

  DeleteOrderDto({this.message, this.orderExists});

  factory DeleteOrderDto.fromJson(Map<String, dynamic> json) {
    return _$DeleteOrderDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeleteOrderDtoToJson(this);
  }
}
