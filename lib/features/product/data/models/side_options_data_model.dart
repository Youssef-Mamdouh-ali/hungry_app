import '../../domain/entities/side_option_entity.dart';

class SideOptionsDataModel extends SideOptionEntity {
  const SideOptionsDataModel({
    required super.name,
    required super.image,
    required super.price,
  });

  factory SideOptionsDataModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return SideOptionsDataModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}