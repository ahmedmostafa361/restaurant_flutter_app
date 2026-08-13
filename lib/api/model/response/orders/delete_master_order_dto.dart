import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_flutter_app/api/model/response/orders/order_details_response_dto.dart';

import 'master_order_exists_dto.dart';

part 'delete_master_order_dto.g.dart';

@JsonSerializable()
class DeleteMasterOrderDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "orderexits")
  final List<MasterOrderExistsDto>? orderExists;
  @JsonKey(name: "singleorders")
  final List<OrderDetailsResponseDto>? singleOrders;

  DeleteMasterOrderDto({this.message, this.orderExists, this.singleOrders});

  factory DeleteMasterOrderDto.fromJson(Map<String, dynamic> json) {
    return _$DeleteMasterOrderDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeleteMasterOrderDtoToJson(this);
  }
}
