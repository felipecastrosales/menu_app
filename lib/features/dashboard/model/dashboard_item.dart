import 'package:menu/features/order/models/order.dart';

class DashboardItem {
  DashboardItem({required this.table, required this.orders});

  final String table;
  final List<Order> orders;

  num get total => orders.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalPrice,
      );
}
