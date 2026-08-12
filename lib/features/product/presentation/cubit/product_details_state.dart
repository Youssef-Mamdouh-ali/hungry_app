import '../../domain/entities/side_option_entity.dart';
import '../../domain/entities/topping_entity.dart';

sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ToppingEntity> toppings;
  final List<SideOptionEntity> sideOptions;

  final List<ToppingEntity> selectedToppings;
  final List<SideOptionEntity> selectedSideOptions;

  final double productPrice;
  final double totalPrice;

  ProductSuccess({
    required this.toppings,
    required this.sideOptions,
    required this.productPrice,
    required this.totalPrice,
    this.selectedToppings = const [],
    this.selectedSideOptions = const [],
  });
}

class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);
}