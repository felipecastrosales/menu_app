import 'package:dio/dio.dart';
import 'package:menu/features/cart/models/order.dart';

import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/product/models/product.dart';

class StrapiDatasourceImpl implements StrapiDatasource {
  static const token =
      'a58965d553db8bb2d8a5924eb6f932cec0fc0533f06b3e32877d39c576bc7574d83a239d480366b55f74f88ec59669a7da2cdb88e645d2d62a6e6c6b664836572adbdc9e83deea48b67e079902947bf66e9ef173387cf01b74ff8fbe5fb92632ea6598e24e901e71d66e00ef872b445c34a067be1c3e462ab0837885c853cffb';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:1337/api',
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  @override
  Future<List<Product>> getProducts({int? categoryId}) async {
    final response = await _dio.get(
      '/products',
      queryParameters: {
        'populate': 'deep',
        if (categoryId != null) 'filters[category][id][\$eq]': categoryId,
      },
    );
    return List<Product>.from(response.data['data']
        .map<Product?>((json) => Product.fromJson(json))
        .where((product) => product != null)
        .toList());
  }

  @override
  Future<Product> getProduct(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await _dio.get(
      '/products/$id',
      queryParameters: {'populate': 'deep'},
    );
    return Product.fromJson(response.data['data'])!;
  }

  @override
  Future<List<HomeSection>> getHomeSections() async {
    final response = await _dio.get(
      '/home',
      queryParameters: {
        'populate': 'deep,7',
      },
    );
    return List<HomeSection>.from(response.data['data']['attributes']
            ['sections']
        .map<HomeSection?>((json) => HomeSection.fromJson(json))
        .where((product) => product != null)
        .toList());
  }

  @override
  Future<List<HomeSection>> getMenuSections() async {
    final response = await _dio.get(
      '/menu',
      queryParameters: {
        'populate': 'deep,7',
      },
    );
    return List<HomeSection>.from(response.data['data']['attributes']
            ['sections']
        .map<HomeSection?>((json) => HomeSection.fromJson(json))
        .where((product) => product != null)
        .toList());
  }

  @override
  Future<void> createOrder(
    Order order,
  ) async {
    await _dio.post(
      '/orders',
      data: order.toJson(),
    );
  }
}

abstract class StrapiDatasource {
  Future<List<Product>> getProducts({int? categoryId});
  Future<Product> getProduct(int id);
  Future<List<HomeSection>> getHomeSections();
  Future<List<HomeSection>> getMenuSections();
  Future<void> createOrder(Order order);
}
