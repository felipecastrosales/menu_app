import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_page_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final DashboardPageController controller = Get.put(DashboardPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.orders.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Wrap(
          children: [
            for (final order in controller.orders.value!)
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '#${order.id}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Mesa: ${order.table}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Status: ${order.status}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              'Itens',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
