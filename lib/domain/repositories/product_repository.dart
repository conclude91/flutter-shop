import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel?> add({required ProductModel product});

  Future<bool> delete({required String id});

  Future<List<ProductModel>> fetch();

  Future<ProductModel?> get({required String id});

  Future<ProductModel?> update({required ProductModel product});
}
