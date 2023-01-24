import 'package:menu/features/product/models/category.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/pages/product/datasources/strapi_datasource.dart';

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
