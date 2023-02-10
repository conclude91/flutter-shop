part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductDeletedState extends ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  const ProductLoadedState({required this.product});

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class ProductFetchedState extends ProductState {
  const ProductFetchedState({required this.listProduct});

  final List<ProductModel> listProduct;

  @override
  List<Object?> get props => [listProduct];
}

class ProductErrorState extends ProductState {
  const ProductErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [];
}
