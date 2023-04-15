import 'package:flutter/material.dart';

import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/models/product_with_discount.dart';
import 'package:menu/features/product/pages/product/widgets/product_list_item.dart';

class ModifierWithProductsWidget extends StatelessWidget {
  const ModifierWithProductsWidget({super.key, required this.modifier});

  final ModifierWithProducts modifier;

  List<ProductWithDiscount> get filteredProducts {
    final number = DateTime.now().weekday;
    return modifier.products.where((p) {
      return p.availableWeekdays.isEmpty ||
          p.availableWeekdays.any((w) => w.number == number);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredProducts.length,
      itemBuilder: (context, i) {
        return ProductListItem(
          productWithDiscount: filteredProducts[i],
          modifier: modifier,
        );
      },
    );
  }
}
