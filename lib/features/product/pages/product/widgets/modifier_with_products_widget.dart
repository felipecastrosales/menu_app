import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';

class ModifierWithProductsWidget extends StatelessWidget {
  const ModifierWithProductsWidget({
    super.key,
    required this.modifier,
  });

  final ModifierWithProducts modifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: modifier.products.length,
      itemBuilder: (context, index) {
        final productModifier = modifier.products[index].product;

        return InkWell(
          onTap: () {},
          splashColor: Colors.white10,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 24,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    productModifier.imageUrl,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModifier.title,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '+ ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(productModifier.basePrice)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
                      color: Theme.of(context).primaryColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
