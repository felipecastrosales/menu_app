import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/product/models/category.dart';
import 'package:menu/features/product/models/product.dart';

class StrapiProductRepository implements ProductRepository {
  final StrapiDatasource _datasource = StrapiDatasourceImpl();

  @override
  Future<List<Product>> getProducts() async {
    return _datasource.getProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(Category category) {
    return _datasource.getProducts(categoryId: category.id);
  }

  @override
  Future<Product> getProduct(int id) async {
    return _datasource.getProduct(id);
  }
}

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(Category category);
  Future<List<Product>> getProducts();
  Future<Product> getProduct(int id);
}
