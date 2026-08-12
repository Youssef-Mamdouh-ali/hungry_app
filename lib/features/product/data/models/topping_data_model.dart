import '../../domain/entities/topping_entity.dart';

class ToppingDataModel extends ToppingEntity {
  const ToppingDataModel({
    required super.name,
    required super.image,
    required super.price,
  });

  factory ToppingDataModel.fromJson(Map<String, dynamic> json) {
    return ToppingDataModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}