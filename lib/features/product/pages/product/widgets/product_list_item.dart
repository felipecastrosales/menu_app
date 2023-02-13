import 'package:flutter/material.dart';
import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/product_with_discount.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_item_action.dart';
import 'package:intl/intl.dart';

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
              foregroundImage:
                  NetworkImage(productWithDiscount.product.imageUrl),
              radius: 20,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (productWithDiscount.total != 0) ...[
                        Text(
                          '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(productWithDiscount.total)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (productWithDiscount.discountPercentage > 0)
                        Text(
                          '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(productWithDiscount.product.basePrice)}',
                          style: const TextStyle(
                            color: Color(0xff5f6066),
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
