import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class FetchProductUseCase {
  FetchProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<List<ProductModel>> call() async {
    return await productRepository.fetch();
  }
}
