class OrderDetails {
  final int? orderID;
  final String? userID;
  final String? itemName;
  final int? quantity;
  final double? itemPrice;
  final double? totalPrice;
  final int? masterID;

  OrderDetails({
    this.orderID,
    this.userID,
    this.itemName,
    this.quantity,
    this.itemPrice,
    this.totalPrice,
    this.masterID,
  });
}
