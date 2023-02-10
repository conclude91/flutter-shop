import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/domain/use_cases/add_product_use_case.dart';
import 'package:shop/domain/use_cases/delete_product_use_case.dart';
import 'package:shop/domain/use_cases/fetch_product_use_case.dart';
import 'package:shop/domain/use_cases/get_product_use_case.dart';
import 'package:shop/domain/use_cases/update_product_use_case.dart';
import 'package:stream_transform/stream_transform.dart';

part 'product_event.dart';
part 'product_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.addProductUseCase,
    required this.deleteProductUseCase,
    required this.fetchProductUseCase,
    required this.getProductUseCase,
    required this.updateProductUseCase,
  }) : super(ProductInitialState()) {
    on<ProductAddEvent>(_add, transformer: debounce(_duration));
    on<ProductDeleteEvent>(_delete, transformer: debounce(_duration));
    on<ProductFetchEvent>(_fetch, transformer: debounce(_duration));
    on<ProductGetEvent>(_get, transformer: debounce(_duration));
    on<ProductUpdateEvent>(_update, transformer: debounce(_duration));
  }

  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final FetchProductUseCase fetchProductUseCase;
  final GetProductUseCase getProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  Future<void> _add(
    ProductAddEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final product = await addProductUseCase.call(product: event.product);
      if (product != null) {
        emit(ProductLoadedState(product: product));
      } else {
        emit(const ProductErrorState(message: 'Add data failed'));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }

  Future<void> _delete(
    ProductDeleteEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final result = await deleteProductUseCase.call(id: event.id);
      if (result) {
        emit(ProductDeletedState());
      } else {
        emit(const ProductErrorState(message: 'No data found'));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }

  Future<void> _fetch(
    ProductFetchEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      List<ProductModel> listProduct = await fetchProductUseCase.call();
      if (event.key.isNotEmpty) {
        listProduct = listProduct
            .where((element) =>
                element.name.toLowerCase().contains(event.key.toLowerCase()))
            .toList();
      }
      emit(ProductFetchedState(listProduct: listProduct));
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }

  Future<void> _get(ProductGetEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final product = await getProductUseCase.call(id: event.id);
      if (product != null) {
        emit(ProductLoadedState(product: product));
      } else {
        emit(const ProductErrorState(message: 'No data found'));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }

  Future<void> _update(
    ProductUpdateEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final product = await updateProductUseCase.call(product: event.product);
      if (product != null) {
        emit(ProductLoadedState(product: product));
      } else {
        emit(const ProductErrorState(message: 'Update data failed'));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }
}
