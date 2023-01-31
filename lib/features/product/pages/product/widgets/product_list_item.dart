import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/product_with_discount.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_item_action.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.modifier,
    required this.productWithDiscount,
  });

  final Modifier modifier;
  final ProductWithDiscount productWithDiscount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: modifier.canAddItem
          ? () {
              modifier.addItem(productWithDiscount);
            }
          : null,
      splashColor: Colors.white10,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              foregroundImage: NetworkImage(
                productWithDiscount.product.imageUrl,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productWithDiscount.product.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (productWithDiscount.totalPrice != 0) ...[
                        Text(
                          '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(productWithDiscount.product.basePrice)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                      const SizedBox(width: 8),
                      if (productWithDiscount.totalPrice > 0)
                        Text(
                          '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(productWithDiscount.product.originalBasePrice)}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
            ModifierItemAction(
              modifier: modifier,
              item: productWithDiscount,
            ),
          ],
        ),
      ),
    );
  }
}
