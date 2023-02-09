import 'package:flutter/material.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class CorePageTitle extends StatelessWidget {
  const CorePageTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
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
          Consumer<CartController>(
            builder: (context, cartController, child) {
              if (cartController.table == null) {
                return const SizedBox.shrink();
              }
              return Text(
                'Mesa ${cartController.table}',
                style: const TextStyle(color: Color(0xff5f6066)),
              );
            },
          )
        ],
      ),
    );
  }
}
