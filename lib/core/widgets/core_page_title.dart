import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:menu/features/cart/controllers/cart_controller.dart';

class CorePageTitle extends StatelessWidget {
  const CorePageTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            if (cartController.table.value == null) return const SizedBox();
            return Text(
              'Mesa ${cartController.table.value}',
              style: const TextStyle(color: Color(0xff5f6066)),
            );
          })
        ],
      ),
    );
  }
}
