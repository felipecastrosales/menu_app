import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/orders/models/order.dart';

class OrderRepository {
  OrderRepository(this._strapiDataSource);

  final StrapiDatasource _strapiDataSource;

  Future<List<Order>> getOrders(OrderStatus? status) async {
    final orders = await _strapiDataSource.getOrders(status);
    return orders.map<Order>((order) => Order.fromMap(order)).toList();
  }
}
