import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menu/core/widgets/core_delete_button.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
            top: 8,
          ),
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: const Color(0Xff2a2e3d),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    product.imageUrl,
                  ),
                ),
                const SizedBox(width: 16),
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
                        const SizedBox(height: 4),
                        for (final modifier in product.modifiers.where(
                            (modifier) => modifier.selectedOptions.isNotEmpty))
                          Text(
                            '${modifier.info.title}: ${modifier.selectedOptions.map((item) => item.title).join('; ')}',
                            style: const TextStyle(
                              color: Color(0xff5f6066),
                              fontSize: 12,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          NumberFormat.simpleCurrency(
                            locale: 'pt_BR',
                          ).format(product.total),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            },
          ),
        ),
      ],
    );
  }
}
