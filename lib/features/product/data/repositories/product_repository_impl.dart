import '../../domain/entities/side_option_entity.dart';
import '../../domain/entities/topping_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_source/product_remote_data_source.dart';
import '../models/side_options_data_model.dart';
import '../models/topping_data_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ToppingEntity>> getToppings() async {
    final data = await remoteDataSource.getToppings();

    return data
        .map((json) => ToppingDataModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<SideOptionEntity>> getSideOptions() async {
    final data = await remoteDataSource.getSideOptions();

    return data
        .map((json) => SideOptionsDataModel.fromJson(json))
        .toList();
  }
}