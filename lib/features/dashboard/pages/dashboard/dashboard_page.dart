import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:menu/features/dashboard/pages/dashboard/dashboard_page_controller.dart';
import 'package:menu/features/dashboard/pages/dashboard/widgets/dashboard_card.dart';
import 'package:menu/features/order/models/order.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.status,
  });

  final OrderStatus? status;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardPageController controller = Get.put(DashboardPageController());

  @override
  void initState() {
    super.initState();
    controller.loadOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardPageController>(
        builder: (_) {
          return Obx(() {
            if (controller.items.value?.isEmpty ?? false) {
              return const Center(
                child: Text(
                  'Nenhum pedido encontrado',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            }

            if (controller.items.value == null) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white,
                  size: 50,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final i in controller.items.value!)
                    DashboardCard(
                      item: i,
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
