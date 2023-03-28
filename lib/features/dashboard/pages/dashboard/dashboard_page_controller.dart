import 'package:get/get.dart';
import 'package:menu/features/orders/models/order.dart';
import 'package:menu/features/orders/repositories/order_repository.dart';

class DashboardPageController extends GetxController {
  final OrderRepository _orderRepository = Get.find();

  Rxn<List<Order>> orders = Rxn<List<Order>>();

  @override
  void onInit() {
    super.onInit();
    _getActiveOrders();
  }

  Future<List<Order>> _getActiveOrders() async {
    final orders = await _orderRepository.getOrders(OrderStatus.preparing);
    this.orders.value = orders;
    return orders;
  }
}
