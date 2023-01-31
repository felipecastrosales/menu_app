import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/pages/product/widgets/product_list_item.dart';

class ModifierWithProductsWidget extends StatelessWidget {
  const ModifierWithProductsWidget({
    super.key,
    required this.modifier,
  });

  final ModifierWithProducts modifier;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: modifier,
      child: Consumer<ModifierWithProducts>(
        builder: (context, value, child) {
          final products = modifier.products;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductListItem(
                productWithDiscount: modifier.products[index],
                modifier: modifier,
              );
            },
          );
        },
      ),
    );
  }
}
