import 'package:json_annotation/json_annotation.dart';

part 'order_details_dto.g.dart';

@JsonSerializable()
class OrderDetailsDto {
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

  OrderDetailsDto({
    this.masterID,
    this.userID,
    this.userCode,
    this.restaurantID,
    this.grandTotal,
  });

  factory OrderDetailsDto.fromJson(Map<String, dynamic> json) {
    return _$OrderDetailsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderDetailsDtoToJson(this);
  }
}