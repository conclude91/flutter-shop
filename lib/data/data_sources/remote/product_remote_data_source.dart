import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel?> add({required ProductModel product});

  Future<bool> delete({required String id});

  Future<List<ProductModel>> fetch();

  Future<ProductModel?> get({required String id});

  Future<ProductModel?> update({required ProductModel product});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<ProductModel?> add({required ProductModel product}) async {
    try {
      ProductModel? result;
      final response = await dio.post(
        'http://localhost/shop/api/product/add',
        data: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200) {
        result = ProductModel.fromJson(response.data['data']);
      }
      return result;
    } on DioError catch (e) {
      throw (DioError(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      ));
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<bool> delete({required String id}) async {
    try {
      bool result = false;
      final response = await dio.delete(
        'http://localhost/shop/api/product/delete',
        data: jsonEncode({'id': id}),
      );
      if (response.statusCode == 200) {
        result = true;
      }
      return result;
    } on DioError catch (e) {
      throw (DioError(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      ));
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProductModel>> fetch() async {
    try {
      List<ProductModel> listProduct = [];
      final response = await dio.get('http://localhost/shop/api/product/fetch');
      for (var data in response.data['data']) {
        ProductModel product = ProductModel.fromJson(data);
        listProduct.add(product);
      }
      return listProduct;
    } on DioError catch (e) {
      throw (DioError(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      ));
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ProductModel?> get({required String id}) async {
    try {
      ProductModel? product;
      final response =
          await dio.get('http://localhost/shop/api/product/get?id=$id');
      for (var data in response.data['data']) {
        product = ProductModel.fromJson(data);
      }
      return product;
    } on DioError catch (e) {
      throw (DioError(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      ));
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ProductModel?> update({required ProductModel product}) async {
    try {
      ProductModel? result;
      final response = await dio.put(
        'http://localhost/shop/api/product/update',
        data: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200) {
        result = ProductModel.fromJson(response.data['data']);
      }
      return result;
    } on DioError catch (e) {
      throw (DioError(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
      ));
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
