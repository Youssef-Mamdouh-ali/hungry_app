import '../../domain/entities/product_entity.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductEntity> products;
  final List<ProductEntity> allProducts;

  HomeSuccess({
    required this.products,
    required this.allProducts,
  });
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}