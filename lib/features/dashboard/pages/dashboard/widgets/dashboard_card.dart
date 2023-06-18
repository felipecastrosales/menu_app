import 'package:flutter/material.dart';
import 'package:menu/core/extensions/duration_extension.dart';
import 'package:menu/core/widgets/core_elevated_button.dart';
import 'package:menu/features/dashboard/model/dashboard_item.dart';
import 'package:menu/features/dashboard/pages/dashboard/dashboard_page_controller.dart';
import 'package:menu/features/order/models/order.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key, required this.item});
  final DashboardItem item;

  IconData icon(Order order) {
    switch (order.status) {
      case OrderStatus.preparing:
        return Icons.access_alarm;
      case OrderStatus.delivered:
        return Icons.check;
      case OrderStatus.paid:
        return Icons.monetization_on_outlined;
    }
  }

  Duration calcDeltaTime(Order order) {
    return DateTime.now().difference(order.createdAt);
  }

  Color cardColor(Order order) {
    final deltaTime = calcDeltaTime(order);

    switch (order.status) {
      case OrderStatus.preparing:
        return deltaTime.inMinutes > 20
            ? Colors.red
            : deltaTime.inMinutes > 15
                ? Colors.yellow
                : Colors.green;
      case OrderStatus.delivered:
        return Colors.green[300]!;
      case OrderStatus.paid:
        return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 32;
    final cards = (screenWidth / 300).floor();
    final cardWidth = (screenWidth - 8 * (cards - 1)) / cards;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      elevation: 0,
      child: SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mesa: ${item.table}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            for (final order in item.orders)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: cardColor(order),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Icon(icon(order)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '#${order.id}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              if (order.status == OrderStatus.preparing)
                                Text(
                                  calcDeltaTime(order).format(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.clientName,
                        ),
                        Text(
                          order.clientPhone,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final p in order.products.length > 4
                          ? order.products
                              .sublist(0, (order.products.length / 2).floor())
                          : order.products)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            top: 0,
                            right: 8,
                            bottom: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      p.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (order.status != OrderStatus.preparing)
                                    Text(
                                      NumberFormat.simpleCurrency(
                                        locale: 'pt_BR',
                                      ).format(p.totalPrice),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                              for (final m in p.modifiers)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    '- ${m.title}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                  if ([OrderStatus.delivered, OrderStatus.paid]
                      .contains(order.status)) ...[
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TOTAL:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'pt_BR')
                                .format(order.totalPrice),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (order.status == OrderStatus.preparing)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CoreElevatedButton(
                        onPressed: () {
                          final DashboardPageController controller = Get.find();
                          controller.setOrderDelivered(order);
                        },
                        padding: const EdgeInsets.all(4),
                        title: 'Marcar como Entregue',
                      ),
                    )
                  else if (order.status == OrderStatus.delivered)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CoreElevatedButton(
                        onPressed: () {
                          final DashboardPageController controller = Get.find();
                          controller.setOrderPaid(order);
                        },
                        color: Colors.grey[700],
                        padding: const EdgeInsets.all(4),
                        title: 'Marcar como Pago',
                      ),
                    )
                ],
              ),
            if (item.orders.length > 1) ...[
              Container(
                height: 1,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TOTAL:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'pt_BR')
                          .format(item.total),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CoreElevatedButton(
                  onPressed: () {
                    final DashboardPageController controller = Get.find();
                    controller.setAllOrdersPaid(item);
                  },
                  color: Colors.grey[700],
                  padding: const EdgeInsets.all(4),
                  title: 'Marcar Todos como Pago',
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
