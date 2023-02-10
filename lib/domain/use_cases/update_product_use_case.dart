import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  UpdateProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<ProductModel?> call({required ProductModel product}) async {
    return await productRepository.update(product: product);
  }
}
