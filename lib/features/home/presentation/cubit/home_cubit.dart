import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  String selectedCategory = 'All';
  String searchQuery = '';

  Future<void> getProducts() async {
    emit(HomeLoading());

    try {
      final products = await getProductsUseCase();

      emit(
        HomeSuccess(
          products: products,
          allProducts: products,
        ),
      );
    } catch (e) {
      emit(
        HomeFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }

  void filterByCategory(String category) {
    selectedCategory = category;
    _applyFilters();
  }

  void searchProducts(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    if (state is! HomeSuccess) return;

    final currentState = state as HomeSuccess;

    List<ProductEntity> filteredProducts =
        currentState.allProducts;

    // Category filter
    if (selectedCategory != 'All') {
      filteredProducts = filteredProducts
          .where(
            (product) =>
        product.category == selectedCategory,
      )
          .toList();
    }

    // Search filter
    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();

      filteredProducts = filteredProducts
          .where(
            (product) =>
        product.name.toLowerCase().contains(query) ||
            product.description
                .toLowerCase()
                .contains(query),
      )
          .toList();
    }

    emit(
      HomeSuccess(
        products: filteredProducts,
        allProducts: currentState.allProducts,
      ),
    );
  }
}