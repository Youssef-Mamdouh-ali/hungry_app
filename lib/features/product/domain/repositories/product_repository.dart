import '../entities/topping_entity.dart';
import '../entities/side_option_entity.dart';

abstract class ProductRepository {
  Future<List<ToppingEntity>> getToppings();

  Future<List<SideOptionEntity>> getSideOptions();
}