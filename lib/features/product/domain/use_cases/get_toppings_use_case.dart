import '../entities/topping_entity.dart';
import '../repositories/product_repository.dart';

class GetToppingsUseCase {
  final ProductRepository repository;

  GetToppingsUseCase(this.repository);

  Future<List<ToppingEntity>> call() {
    return repository.getToppings();
  }
}