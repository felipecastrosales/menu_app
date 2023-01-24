import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_item_action.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.modifier,
    required this.product,
  });

  final Modifier modifier;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.white10,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(product.imageUrl),
              radius: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(product.basePrice)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
            ModifierItemAction(
              modifier: modifier,
              item: product,
            ),
          ],
        ),
      ),
    );
  }
}
