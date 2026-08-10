import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/cart_item.dart';
import 'package:restaurant_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';

void main() {
  late CartViewModel cartViewModel;

  setUp(() {
    cartViewModel = CartViewModel();
  });

  tearDown(() {
    cartViewModel.close();
  });

  group('CartViewModel', () {
    test('initial state has empty items and zero total', () {
      final state = cartViewModel.state as CartUpdatedState;
      expect(state.items, isEmpty);
      expect(state.totalPrice, 0);
    });

    group('addItem', () {
      blocTest<CartViewModel, CartStates>(
        'adds a new item to an empty cart',
        build: () => cartViewModel,
        act: (cubit) =>
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 2),
              restaurantId: 4,
            ),
        expect: () =>
        [
          isA<CartUpdatedState>()
              .having((s) => s.items.length, 'items.length', 1)
              .having((s) => s.items.first.itemName, 'itemName',
              'Chicken Biryani')
              .having((s) => s.items.first.quantity, 'quantity', 2)
              .having((s) => s.totalPrice, 'totalPrice', 560),
        ],
      );

      blocTest<CartViewModel, CartStates>(
        'adding the same item twice merges quantities instead of duplicating',
        build: () => cartViewModel,
        act: (cubit) {
          cubit.addItem(
            CartItem(itemName: 'Chicken Biryani', itemPrice: 280, quantity: 1),
            restaurantId: 4,
          );
          cubit.addItem(
            CartItem(itemName: 'Chicken Biryani', itemPrice: 280, quantity: 2),
            restaurantId: 4,
          );
        },
        expect: () =>
        [
          isA<CartUpdatedState>().having((s) => s.items.length, 'items.length',
              1),
          isA<CartUpdatedState>()
              .having((s) => s.items.length, 'items.length', 1)
              .having((s) => s.items.first.quantity, 'quantity', 3)
              .having((s) => s.totalPrice, 'totalPrice', 840),
        ],
      );

      blocTest<CartViewModel, CartStates>(
        'adding an item from a different restaurant clears the old cart first',
        build: () => cartViewModel,
        act: (cubit) {
          cubit.addItem(
            CartItem(itemName: 'Chicken Biryani', itemPrice: 280, quantity: 2),
            restaurantId: 4,
          );
          cubit.addItem(
            CartItem(itemName: 'Kofta Curry', itemPrice: 300, quantity: 1),
            restaurantId: 9, // different restaurant
          );
        },
        expect: () =>
        [
          isA<CartUpdatedState>() // after first addItem
              .having((s) => s.items.length, 'items.length', 1)
              .having((s) => s.items.first.itemName, 'itemName',
              'Chicken Biryani'),
          isA<CartUpdatedState>() // clearCart() fires internally
              .having((s) => s.items, 'items', isEmpty),
          isA<CartUpdatedState>() // new item added after clear
              .having((s) => s.items.length, 'items.length', 1)
              .having((s) => s.items.first.itemName, 'itemName', 'Kofta Curry'),
        ],
        verify: (cubit) {
          expect(cubit.currentRestaurantId, 9);
        },
      );

      group('incrementQuantity', () {
        blocTest<CartViewModel, CartStates>(
          'increments quantity of an existing item',
          build: () => cartViewModel,
          seed: () =>
              CartUpdatedState(
                items: [
                  CartItem(
                      itemName: 'Chicken Biryani', itemPrice: 280, quantity: 1)
                ],
                totalPrice: 280,
              ),
          act: (cubit) {
            // seed() sets initial state but doesn't populate the private _items list,
            // so we build state through the real API instead
          },
          skip: 0,
        );

        // Since _items is private and not affected by seed(), build state via addItem first
        blocTest<CartViewModel, CartStates>(
          'incrementQuantity increases quantity by 1',
          build: () => cartViewModel,
          act: (cubit) {
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 1),
              restaurantId: 4,
            );
            cubit.incrementQuantity('Chicken Biryani');
          },
          skip: 1,
          // skip the emission from addItem, only assert the final state
          expect: () =>
          [
            isA<CartUpdatedState>()
                .having((s) => s.items.first.quantity, 'quantity', 2)
                .having((s) => s.totalPrice, 'totalPrice', 560),
          ],
        );

        blocTest<CartViewModel, CartStates>(
          'incrementQuantity on a non-existent item does nothing',
          build: () => cartViewModel,
          act: (cubit) => cubit.incrementQuantity('Nonexistent Item'),
          expect: () => [], // no emission, since the method returns early
        );
      });

      group('decrementQuantity', () {
        blocTest<CartViewModel, CartStates>(
          'decrements quantity when above 1',
          build: () => cartViewModel,
          act: (cubit) {
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 3),
              restaurantId: 4,
            );
            cubit.decrementQuantity('Chicken Biryani');
          },
          skip: 1,
          expect: () =>
          [
            isA<CartUpdatedState>()
                .having((s) => s.items.first.quantity, 'quantity', 2)
                .having((s) => s.totalPrice, 'totalPrice', 560),
          ],
        );

        blocTest<CartViewModel, CartStates>(
          'decrementing quantity below 1 removes the item entirely',
          build: () => cartViewModel,
          act: (cubit) {
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 1),
              restaurantId: 4,
            );
            cubit.decrementQuantity('Chicken Biryani');
          },
          skip: 1,
          expect: () =>
          [
            isA<CartUpdatedState>()
                .having((s) => s.items, 'items', isEmpty)
                .having((s) => s.totalPrice, 'totalPrice', 0),
          ],
        );

        blocTest<CartViewModel, CartStates>(
          'decrementQuantity on a non-existent item does nothing',
          build: () => cartViewModel,
          act: (cubit) => cubit.decrementQuantity('Nonexistent Item'),
          expect: () => [],
        );
      });

      group('removeItem', () {
        blocTest<CartViewModel, CartStates>(
          'removes the specified item regardless of quantity',
          build: () => cartViewModel,
          act: (cubit) {
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 5),
              restaurantId: 4,
            );
            cubit.removeItem('Chicken Biryani');
          },
          skip: 1,
          expect: () =>
          [
            isA<CartUpdatedState>()
                .having((s) => s.items, 'items', isEmpty)
                .having((s) => s.totalPrice, 'totalPrice', 0),
          ],
        );
      });

      group('clearCart', () {
        blocTest<CartViewModel, CartStates>(
          'empties all items and resets currentRestaurantId',
          build: () => cartViewModel,
          act: (cubit) {
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 2),
              restaurantId: 4,
            );
            cubit.clearCart();
          },
          skip: 1,
          expect: () =>
          [
            isA<CartUpdatedState>()
                .having((s) => s.items, 'items', isEmpty)
                .having((s) => s.totalPrice, 'totalPrice', 0),
          ],
          verify: (cubit) {
            expect(cubit.currentRestaurantId, isNull);
          },
        );
      });

      group('running total calculation', () {
        blocTest<CartViewModel, CartStates>(
          'totalPrice correctly sums multiple different items',
          build: () => cartViewModel,
          act: (cubit) {
            cubit.addItem(
              CartItem(
                  itemName: 'Chicken Biryani', itemPrice: 280, quantity: 2),
              // 560
              restaurantId: 4,
            );
            cubit.addItem(
              CartItem(itemName: 'Kofta Curry', itemPrice: 300, quantity: 1),
              // 300
              restaurantId: 4,
            );
          },
          skip: 1,
          expect: () =>
          [
            isA<CartUpdatedState>()
                .having((s) => s.items.length, 'items.length', 2)
                .having((s) => s.totalPrice, 'totalPrice', 860), // 560 + 300
          ],
        );
      });
    });
  });
}