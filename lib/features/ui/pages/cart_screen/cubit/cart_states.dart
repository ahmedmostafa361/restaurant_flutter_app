import '../../../../../domain/entinties/request/cart_item.dart';

abstract class CartStates {}

class CartUpdatedState extends CartStates {
  final List<CartItem> items;
  final double totalPrice;

  CartUpdatedState({required this.items, required this.totalPrice});
}
