import 'package:either_dart/either.dart';

import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/product/models/category.dart';
import 'package:menu/features/product/models/product.dart';

class StrapiProductRepository implements ProductRepository {
  StrapiProductRepository(this._datasource);
  final StrapiDatasource _datasource;

  @override
  Future<List<Product>> getProducts() async {
    return _datasource.getProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(Category category) {
    return _datasource.getProducts(categoryId: category.id);
  }

  @override
  Future<Either<GetProductError, Product>> getProduct(int id) async {
    return await _datasource.getProduct(id);
  }
}

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(Category category);

  Future<List<Product>> getProducts();

  Future<Either<GetProductError, Product>> getProduct(int id);
}
