import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:menu/core/routes/app_routes.dart';
import 'package:menu/core/widgets/core_delete_button.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/product/models/product.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 8),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: const Color(0xff2a2e3d),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(product.imageUrl),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (final m in product.modifiers
                            .where((m) => m.selectedOptions.isNotEmpty))
                          Text(
                            '${m.info.title}: ${m.selectedOptions.map((e) => e.title).join(', ')}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff5f6066),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          NumberFormat.simpleCurrency(locale: 'pt_BR')
                              .format(product.total),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CoreDeleteButton(
            onTap: () {
              final cartController = context.read<CartController>();
              cartController.removeProduct(product);
              if (cartController.products.isEmpty) {
                Get.toNamed(AppRoutes.menu.path);
              }
            },
          ),
        )
      ],
    );
  }
}
