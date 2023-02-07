import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class HomeCartDrawer extends StatelessWidget {
  const HomeCartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return SizedBox(
      width: 102,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return const SizedBox();
                },
              ),
            ),
            Text(
              '${cartController.productCount} ${cartController.productCount == 1 ? 'item' : 'items'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Total:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              NumberFormat.currency(
                symbol: '\$',
              ).format(
                cartController.totalPrice,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            if (cartController.productCount > 0) ...[
              SizedBox.square(
                dimension: 54,
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(27),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
