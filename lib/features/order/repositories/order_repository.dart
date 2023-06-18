import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/order/models/order.dart';

class OrderRepository {
  OrderRepository(this._datasource);

  final StrapiDatasource _datasource;

  Future<List<Order>> getOrders(OrderStatus? status) {
    return _datasource.getOrders(status: status);
  }

  Future<void> setOrderStatus(int orderId, OrderStatus status) {
    return _datasource.setOrderStatus(orderId, status);
  }
}
