import '../entities/side_option_entity.dart';
import '../repositories/product_repository.dart';

class GetSideOptionsUseCase {
  final ProductRepository repository;

  GetSideOptionsUseCase(this.repository);

  Future<List<SideOptionEntity>> call() {
    return repository.getSideOptions();
  }
}