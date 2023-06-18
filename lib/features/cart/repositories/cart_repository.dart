import 'package:menu/features/cart/models/create_order_model.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';

class CartRepository {
  CartRepository(this._datasource);
  final StrapiDatasource _datasource;

  Future<int> createOrder(CreateOrderModel order) async {
    final orderId = await _datasource.createOrder(order);
    return orderId;
  }
}
