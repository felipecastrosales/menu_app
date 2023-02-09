import 'package:menu/features/cart/models/order.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';

class CartRepository {
  final StrapiDatasource _datasource = StrapiDatasourceImpl();

  Future<void> createOrder(Order order) async {
    await _datasource.createOrder(order);
  }
}
