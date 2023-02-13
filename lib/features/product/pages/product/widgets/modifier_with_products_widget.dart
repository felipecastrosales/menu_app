import 'package:flutter/material.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/pages/product/widgets/product_list_item.dart';
import 'package:provider/provider.dart';

class ModifierWithProductsWidget extends StatelessWidget {
  const ModifierWithProductsWidget({super.key, required this.modifier});

  final ModifierWithProducts modifier;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: modifier,
      child: Consumer<ModifierWithProducts>(
        builder: (_, __, ___) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: modifier.products.length,
            itemBuilder: (context, i) {
              return ProductListItem(
                productWithDiscount: modifier.products[i],
                modifier: modifier,
              );
            },
          );
        },
      ),
    );
  }
}
