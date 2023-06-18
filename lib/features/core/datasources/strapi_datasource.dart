import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'package:menu/features/cart/models/create_order_model.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/order/models/order.dart';
import 'package:menu/features/product/models/product.dart';

class StrapiDatasourceImpl implements StrapiDatasource {
  StrapiDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Product>> getProducts({int? categoryId}) async {
    final response = await _dio.get(
      '/products',
      queryParameters: {
        'populate': 'deep',
        if (categoryId != null) 'filters[category][id][\$eq]': categoryId,
      },
    );
    return List<Product>.from(
      response.data['data']
          .map<Product?>((json) => Product.fromJson(json))
          .where((p) => p != null)
          .toList(),
    );
  }

  @override
  Future<Either<GetProductError, Product>> getProduct(int id) async {
    try {
      final response = await _dio.get(
        '/products/$id',
        queryParameters: {
          'populate': 'deep',
        },
      );
      return Right(Product.fromJson(response.data['data'])!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return const Left(GetProductError.notFound);
      } else {
        return const Left(GetProductError.unknown);
      }
    } catch (_) {
      return const Left(GetProductError.unknown);
    }
  }

  @override
  Future<List<HomeSection>> getHomeSections() async {
    final response = await _dio.get(
      '/home',
      queryParameters: {
        'populate': 'deep,6',
      },
    );
    return List<HomeSection>.from(
      response.data['data']['attributes']['sections']
          .map<HomeSection?>((json) => HomeSection.fromJson(json))
          .where((p) => p != null)
          .toList(),
    );
  }

  @override
  Future<List<HomeSection>> getMenuSections() async {
    final response = await _dio.get(
      '/menu',
      queryParameters: {
        'populate': 'deep,6',
      },
    );
    return List<HomeSection>.from(
      response.data['data']['attributes']['sections']
          .map<HomeSection?>((json) => HomeSection.fromJson(json))
          .where((p) => p != null)
          .toList(),
    );
  }

  @override
  Future<int> createOrder(CreateOrderModel order) async {
    final response = await _dio.post(
      '/orders',
      data: {
        'data': order.toJson(),
      },
    );

    return response.data['data']['id'];
  }

  @override
  Future<List<Order>> getOrders({OrderStatus? status}) async {
    final response = await _dio.get(
      '/orders',
      queryParameters: {
        if (status != null) 'filters[status][\$eq]': status.name,
        'populate': 'deep',
        'sort': 'createdAt:asc'
      },
    );

    return response.data['data'].map<Order>((o) => Order.fromMap(o)).toList();
  }

  @override
  Future<void> setOrderStatus(int orderId, OrderStatus status) async {
    await _dio.put(
      '/orders/$orderId',
      data: {
        'data': {'status': status.name},
      },
    );
  }
}

abstract class StrapiDatasource {
  Future<List<Product>> getProducts({int? categoryId});
  Future<Either<GetProductError, Product>> getProduct(int id);
  Future<List<HomeSection>> getHomeSections();
  Future<List<HomeSection>> getMenuSections();
  Future<int> createOrder(CreateOrderModel order);
  Future<List<Order>> getOrders({OrderStatus? status});
  Future<void> setOrderStatus(int orderId, OrderStatus status);
}

enum GetProductError { notFound, unknown }
