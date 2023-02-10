part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductAddEvent extends ProductEvent {
  const ProductAddEvent({required this.product});

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class ProductDeleteEvent extends ProductEvent {
  const ProductDeleteEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

class ProductFetchEvent extends ProductEvent {
  const ProductFetchEvent({this.key = ''});

  final String key;

  @override
  List<Object?> get props => [];
}

class ProductGetEvent extends ProductEvent {
  const ProductGetEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

class ProductUpdateEvent extends ProductEvent {
  const ProductUpdateEvent({required this.product});

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}
