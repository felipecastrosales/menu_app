import 'package:menu/features/cart/models/order.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';

class CartRepository {
  final StrapiDatasource datasource = StrapiDatasourceImpl();

  Future<void> createOrder(Order order) {
    return datasource.createOrder(order);
  }
}
