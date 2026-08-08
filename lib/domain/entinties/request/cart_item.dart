class CartItem {
  final String itemName;
  final double itemPrice;
  final int quantity;
  final String? imageUrl;

  CartItem({
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    this.imageUrl,
  });

  double get totalPrice => itemPrice * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      itemName: itemName,
      itemPrice: itemPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl,
    );
  }
}