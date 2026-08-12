import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item_entity.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartUpdated(items: []));

  void addToCart(CartItemEntity item) {
    if (state is! CartUpdated) return;

    final currentState = state as CartUpdated;

    final items = [
      ...currentState.items,
      item,
    ];

    emit(
      CartUpdated(
        items: items,
      ),
    );
  }

  void removeFromCart(int index) {
    if (state is! CartUpdated) return;

    final currentState = state as CartUpdated;

    final items = [
      ...currentState.items,
    ];

    if (index < 0 || index >= items.length) return;

    items.removeAt(index);

    emit(
      CartUpdated(
        items: items,
      ),
    );
  }

  void increaseQuantity(int index) {
    if (state is! CartUpdated) return;

    final currentState = state as CartUpdated;

    final items = [
      ...currentState.items,
    ];

    if (index < 0 || index >= items.length) return;

    final item = items[index];

    items[index] = CartItemEntity(
      product: item.product,
      toppings: item.toppings,
      sideOptions: item.sideOptions,
      spicyLevel: item.spicyLevel,
      quantity: item.quantity + 1,
    );

    emit(
      CartUpdated(
        items: items,
      ),
    );
  }

  void decreaseQuantity(int index) {
    if (state is! CartUpdated) return;

    final currentState = state as CartUpdated;

    final items = [
      ...currentState.items,
    ];

    if (index < 0 || index >= items.length) return;

    final item = items[index];

    if (item.quantity <= 1) {
      items.removeAt(index);
    } else {
      items[index] = CartItemEntity(
        product: item.product,
        toppings: item.toppings,
        sideOptions: item.sideOptions,
        spicyLevel: item.spicyLevel,
        quantity: item.quantity - 1,
      );
    }

    emit(
      CartUpdated(
        items: items,
      ),
    );
  }

  void clearCart() {
    emit(
      CartUpdated(
        items: [],
      ),
    );
  }
}