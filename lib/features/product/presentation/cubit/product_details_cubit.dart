import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/side_option_entity.dart';
import '../../domain/entities/topping_entity.dart';
import '../../domain/use_cases/get_side_options_use_case.dart';
import '../../domain/use_cases/get_toppings_use_case.dart';
import 'product_details_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetToppingsUseCase getToppingsUseCase;
  final GetSideOptionsUseCase getSideOptionsUseCase;

  ProductCubit({
    required this.getToppingsUseCase,
    required this.getSideOptionsUseCase,
  }) : super(ProductInitial());

  Future<void> getProductOptions(double productPrice) async {
    emit(ProductLoading());

    try {
      final results = await Future.wait([
        getToppingsUseCase(),
        getSideOptionsUseCase(),
      ]);

      final toppings = results[0] as List<ToppingEntity>;
      final sideOptions = results[1] as List<SideOptionEntity>;

      emit(
        ProductSuccess(
          toppings: toppings,
          sideOptions: sideOptions,
          productPrice: productPrice,
          totalPrice: productPrice,
        ),
      );
    } catch (e) {
      emit(
        ProductFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }

  // =========================
  // Topping
  // =========================

  void toggleTopping(ToppingEntity topping) {
    if (state is! ProductSuccess) return;

    final currentState = state as ProductSuccess;

    final selectedToppings = [
      ...currentState.selectedToppings,
    ];

    if (selectedToppings.contains(topping)) {
      selectedToppings.remove(topping);
    } else {
      selectedToppings.add(topping);
    }

    final totalPrice = _calculateTotal(
      productPrice: currentState.productPrice,
      selectedToppings: selectedToppings,
      selectedSideOptions: currentState.selectedSideOptions,
    );

    emit(
      ProductSuccess(
        toppings: currentState.toppings,
        sideOptions: currentState.sideOptions,
        productPrice: currentState.productPrice,
        selectedToppings: selectedToppings,
        selectedSideOptions: currentState.selectedSideOptions,
        totalPrice: totalPrice,
      ),
    );
  }

  // =========================
  // Side Option
  // =========================

  void toggleSideOption(SideOptionEntity sideOption) {
    if (state is! ProductSuccess) return;

    final currentState = state as ProductSuccess;

    final selectedSideOptions = [
      ...currentState.selectedSideOptions,
    ];

    if (selectedSideOptions.contains(sideOption)) {
      selectedSideOptions.remove(sideOption);
    } else {
      selectedSideOptions.add(sideOption);
    }

    final totalPrice = _calculateTotal(
      productPrice: currentState.productPrice,
      selectedToppings: currentState.selectedToppings,
      selectedSideOptions: selectedSideOptions,
    );

    emit(
      ProductSuccess(
        toppings: currentState.toppings,
        sideOptions: currentState.sideOptions,
        productPrice: currentState.productPrice,
        selectedToppings: currentState.selectedToppings,
        selectedSideOptions: selectedSideOptions,
        totalPrice: totalPrice,
      ),
    );
  }

  // =========================
  // Calculate Total
  // =========================

  double _calculateTotal({
    required double productPrice,
    required List<ToppingEntity> selectedToppings,
    required List<SideOptionEntity> selectedSideOptions,
  }) {
    double total = productPrice;

    for (final topping in selectedToppings) {
      total += topping.price;
    }

    for (final sideOption in selectedSideOptions) {
      total += sideOption.price;
    }

    return total;
  }
}