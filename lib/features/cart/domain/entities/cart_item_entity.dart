import 'package:hungry_app/features/product/domain/entities/side_option_entity.dart';
import 'package:hungry_app/features/product/domain/entities/topping_entity.dart';

import '../../../home/domain/entities/product_entity.dart';


class CartItemEntity {
  final ProductEntity product;
  final int quantity;
  final List<ToppingEntity> toppings;
  final List<SideOptionEntity> sideOptions;
  final double spicyLevel;

  const CartItemEntity({
    required this.product,
    required this.quantity,
    required this.toppings,
    required this.sideOptions,
    required this.spicyLevel,
  });

  double get unitPrice {
    double price = product.price;

    for (final topping in toppings) {
      price += topping.price;
    }

    for (final sideOption in sideOptions) {
      price += sideOption.price;
    }

    return price;
  }

  double get totalPrice {
    return unitPrice * quantity;
  }
}