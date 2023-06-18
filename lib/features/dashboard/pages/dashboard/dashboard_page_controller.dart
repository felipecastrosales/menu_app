import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:menu/features/dashboard/model/dashboard_item.dart';
import 'package:menu/features/order/models/order.dart';
import 'package:menu/features/order/repositories/order_repository.dart';
import 'package:get/get.dart';

class DashboardPageController extends GetxController {
  DashboardPageController();
  OrderStatus? status;
  final OrderRepository _orderRepository = Get.find();
  Rxn<List<DashboardItem>> items = Rxn<List<DashboardItem>>();
  late Timer _timer;
  int _count = 0;

  void loadOrders(OrderStatus? status) {
    this.status = status;
    _getOrders();
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  Future<void> _getOrders() async {
    try {
      final orders = await _orderRepository.getOrders(status);
      if (status == OrderStatus.delivered) {
        final items = <DashboardItem>[];
        for (final o in orders) {
          if (items.any((i) => i.table == o.table)) {
            items.firstWhere((i) => i.table == o.table).orders.add(o);
          } else {
            items.add(DashboardItem(table: o.table, orders: [o]));
          }
        }
        this.items.value = items;
      } else {
        items.value = orders
            .map<DashboardItem>(
              (e) => DashboardItem(table: e.table, orders: [e]),
            )
            .toList();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
      _count++;
      if (_count >= 5) {
        _count = 0;
        _getOrders();
      }
    });
  }

  Future<void> setOrderDelivered(Order order) async {
    _removeOrderFromDashboard(order);

    await _orderRepository.setOrderStatus(order.id, OrderStatus.delivered);
  }

  Future<void> setOrderPaid(Order order) async {
    _removeOrderFromDashboard(order);

    await _orderRepository.setOrderStatus(order.id, OrderStatus.paid);
  }

  Future<void> setAllOrdersPaid(DashboardItem item) async {
    while (item.orders.isNotEmpty) {
      setOrderPaid(item.orders.first);
    }
  }

  void _removeOrderFromDashboard(Order order) {
    items.update((items) {
      final item = items!.firstWhere((i) => i.table == order.table);
      item.orders.remove(order);
      if (item.orders.isEmpty) {
        items.remove(item);
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
  }
}
