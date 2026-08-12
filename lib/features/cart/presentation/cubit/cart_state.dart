import '../../domain/entities/cart_item_entity.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItemEntity> items;

  CartUpdated({
    required this.items,
  });

  double get totalPrice {
    double total = 0;

    for (final item in items) {
      total += item.totalPrice;
    }

    return total;
  }
}