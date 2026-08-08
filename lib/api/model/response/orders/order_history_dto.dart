import 'package:json_annotation/json_annotation.dart';

part 'order_history_dto.g.dart';

@JsonSerializable()
class OrderDetailsHistoryDto {
  @JsonKey(name: "masterID")
  final int? masterID;
  @JsonKey(name: "userID")
  final String? userID;
  @JsonKey(name: "usercode")
  final String? userCode;
  @JsonKey(name: "restaurantID")
  final int? restaurantID;
  @JsonKey(name: "grandtotal")
  final double? grandTotal;

  OrderDetailsHistoryDto({
    this.masterID,
    this.userID,
    this.userCode,
    this.restaurantID,
    this.grandTotal,
  });

  factory OrderDetailsHistoryDto.fromJson(Map<String, dynamic> json) {
    return _$OrderDetailsHistoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderDetailsHistoryDtoToJson(this);
  }
}