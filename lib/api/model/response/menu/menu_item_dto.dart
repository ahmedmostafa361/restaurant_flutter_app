import 'package:json_annotation/json_annotation.dart';

part 'menu_item_dto.g.dart';

@JsonSerializable()
class MenuItemDto {
  @JsonKey(name: "itemID")
  final int? itemID;
  @JsonKey(name: "itemName")
  final String? itemName;
  @JsonKey(name: "itemDescription")
  final String? itemDescription;
  @JsonKey(name: "itemPrice")
  final double? itemPrice;
  @JsonKey(name: "restaurantName")
  final String? restaurantName;
  @JsonKey(name: "restaurantID")
  final int? restaurantID;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;

  MenuItemDto({
    this.itemID,
    this.itemName,
    this.itemDescription,
    this.itemPrice,
    this.restaurantName,
    this.restaurantID,
    this.imageUrl,
  });

  factory MenuItemDto.fromJson(Map<String, dynamic> json) {
    return _$MenuItemDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MenuItemDtoToJson(this);
  }
}
