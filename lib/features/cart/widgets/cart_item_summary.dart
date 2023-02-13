import 'package:flutter/material.dart';
import 'package:menu/core/widgets/core_delete_button.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:provider/provider.dart';

class CartItemSummary extends StatelessWidget {
  const CartItemSummary({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 78,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(product.imageUrl),
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
                child: CoreDeleteButton(
                  onTap: () {
                    context.read<CartController>().removeProduct(product);
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          child: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
