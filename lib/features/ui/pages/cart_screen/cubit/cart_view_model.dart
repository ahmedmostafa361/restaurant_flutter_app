import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entinties/request/cart_item.dart';
import 'cart_states.dart';

@lazySingleton
class CartViewModel extends Cubit<CartStates> {
  final List<CartItem> _items = [];
  int? currentRestaurantId; // menu items only make sense tied to one restaurant

  CartViewModel() : super(CartUpdatedState(items: [], totalPrice: 0));

  void addItem(CartItem item, {required int restaurantId}) {
    // Enforce single-restaurant cart — this API places one order per restaurant
    if (currentRestaurantId != null && currentRestaurantId != restaurantId) {
      clearCart();
    }
    currentRestaurantId = restaurantId;

    final index = _items.indexWhere((i) => i.itemName == item.itemName);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
          quantity: _items[index].quantity + item.quantity);
    } else {
      _items.add(item);
    }
    _emitUpdated();
  }

  void incrementQuantity(String itemName) {
    final index = _items.indexWhere((i) => i.itemName == itemName);
    if (index < 0) return;
    _items[index] =
        _items[index].copyWith(quantity: _items[index].quantity + 1);
    _emitUpdated();
  }

  void decrementQuantity(String itemName) {
    final index = _items.indexWhere((i) => i.itemName == itemName);
    if (index < 0) return;
    if (_items[index].quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] =
          _items[index].copyWith(quantity: _items[index].quantity - 1);
    }
    _emitUpdated();
  }

  void removeItem(String itemName) {
    _items.removeWhere((i) => i.itemName == itemName);
    _emitUpdated();
  }

  void clearCart() {
    _items.clear();
    currentRestaurantId = null;
    _emitUpdated();
  }

  void _emitUpdated() {
    final total = _items.fold<double>(0, (sum, item) => sum + item.totalPrice);
    emit(CartUpdatedState(items: List.unmodifiable(_items), totalPrice: total));
  }
}