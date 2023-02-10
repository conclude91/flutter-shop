import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetProductUseCase {
  GetProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<ProductModel?> call({required String id}) async {
    return await productRepository.get(id: id);
  }
}
