import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase {
  AddProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<ProductModel?> call({required ProductModel product}) async {
    return await productRepository.add(product: product);
  }
}
