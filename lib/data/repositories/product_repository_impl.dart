import 'package:shop/data/data_sources/remote/product_remote_data_source.dart';

import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.productRemoteDataSource});

  final ProductRemoteDataSource productRemoteDataSource;

  @override
  Future<ProductModel?> add({required ProductModel product}) async {
    return await productRemoteDataSource.add(product: product);
  }

  @override
  Future<bool> delete({required String id}) async {
    return await productRemoteDataSource.delete(id: id);
  }

  @override
  Future<List<ProductModel>> fetch() async {
    return await productRemoteDataSource.fetch();
  }

  @override
  Future<ProductModel?> get({required String id}) async {
    return await productRemoteDataSource.get(id: id);
  }

  @override
  Future<ProductModel?> update({required ProductModel product}) async {
    return await productRemoteDataSource.update(product: product);
  }
}
