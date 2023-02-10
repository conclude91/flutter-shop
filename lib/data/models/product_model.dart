import 'package:shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required String id,
    required String image,
    required String name,
    required String description,
  }) : super(id: id, image: image, name: name, description: description);

  ProductModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          image: json['image'],
          name: json['name'],
          description: json['description'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'description': description,
      };
}
