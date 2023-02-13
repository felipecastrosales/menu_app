import 'package:dio/dio.dart';
import 'package:menu/features/cart/models/order.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/product/models/product.dart';

class StrapiDatasourceImpl implements StrapiDatasource {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://localhost:1337/api', headers: {
    'Authorization':
        'Bearer e3e138cf15a45aef7c6e287c6f41b0763f7dbe6e5bcd37481f6e10d767a70be2bbdc5eb9866cfd26e7f0ae8d6ce74437f39cd8e263e37dd321a1e34aed4e071af9f6f20ed8d5ab2b5bd8105bd1ae42f6c8c4c8eae937399418cdfcf845598ee7f634e16c062ba677e715801e7699354911f2b63ca8fe7b2108432bce979bb674'
  },),);

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
        .where((p) => p != null)
        .toList(),);
  }

  @override
  Future<Product> getProduct(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
        await _dio.get('/products/$id', queryParameters: {'populate': 'deep'});
    return Product.fromJson(response.data['data'])!;
  }

  @override
  Future<List<HomeSection>> getHomeSections() async {
    final response = await _dio.get(
      '/home',
      queryParameters: {
        'populate': 'deep,6',
      },
    );
    return List<HomeSection>.from(response.data['data']['attributes']
            ['sections']
        .map<HomeSection?>((json) => HomeSection.fromJson(json))
        .where((p) => p != null)
        .toList(),);
  }

  @override
  Future<List<HomeSection>> getMenuSections() async {
    final response = await _dio.get(
      '/menu',
      queryParameters: {
        'populate': 'deep,6',
      },
    );
    return List<HomeSection>.from(response.data['data']['attributes']
            ['sections']
        .map<HomeSection?>((json) => HomeSection.fromJson(json))
        .where((p) => p != null)
        .toList(),);
  }

  @override
  Future<void> createOrder(Order order) async {
    await _dio.post('/orders', data: {
      'data': order.toJson(),
    },);
  }
}

abstract class StrapiDatasource {
  Future<List<Product>> getProducts({int? categoryId});
  Future<Product> getProduct(int id);
  Future<List<HomeSection>> getHomeSections();
  Future<List<HomeSection>> getMenuSections();
  Future<void> createOrder(Order order);
}
