import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  DeleteProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<bool> call({required String id}) async {
    return await productRepository.delete(id: id);
  }
}
