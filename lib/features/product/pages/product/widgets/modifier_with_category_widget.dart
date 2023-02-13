import 'package:flutter/material.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/models/product_with_discount.dart';
import 'package:menu/features/product/pages/product/widgets/product_list_item.dart';
import 'package:menu/features/product/repositories/product_repository.dart';
import 'package:provider/provider.dart';

class ModifierWithCategoryWidget extends StatelessWidget {
  const ModifierWithCategoryWidget({super.key, required this.modifier});

  final ModifierWithCategory modifier;

  @override
  Widget build(BuildContext context) {
    final future =
        StrapiProductRepository().getProductsByCategory(modifier.category);

    return ChangeNotifierProvider.value(
      value: modifier,
      child: Consumer<ModifierWithCategory>(
        builder: (_, __, ___) {
          return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return ProductListItem(
                    productWithDiscount: ProductWithDiscount(
                      product: snapshot.data![i],
                      discountPercentage: 0,
                    ),
                    modifier: modifier,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
