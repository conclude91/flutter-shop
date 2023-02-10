import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop/data/repositories/product_repository_impl.dart';
import 'package:shop/domain/repositories/product_repository.dart';
import 'package:shop/domain/use_cases/add_product_use_case.dart';
import 'package:shop/domain/use_cases/delete_product_use_case.dart';
import 'package:shop/domain/use_cases/fetch_product_use_case.dart';
import 'package:shop/domain/use_cases/get_product_use_case.dart';
import 'package:shop/domain/use_cases/update_product_use_case.dart';
import 'package:shop/presentation/blocs/product/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => ProductBloc(
      addProductUseCase: sl(),
      deleteProductUseCase: sl(),
      fetchProductUseCase: sl(),
      getProductUseCase: sl(),
      updateProductUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => FetchProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => GetProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(productRepository: sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSource: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton(() => Dio());
}
