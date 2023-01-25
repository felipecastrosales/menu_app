import 'package:flutter/material.dart';

import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/pages/product/widgets/product_list_item.dart';
import 'package:menu/features/product/repositories/product_repository.dart';
import 'package:provider/provider.dart';

class ModifierWithCategoryWidget extends StatelessWidget {
  const ModifierWithCategoryWidget({
    super.key,
    required this.modifier,
  });

  final ModifierWithCategory modifier;

  @override
  Widget build(BuildContext context) {
    final getProductsByCategory =
        StrapiProductRepository().getProductsByCategory(modifier.category);

    return ChangeNotifierProvider.value(
      value: modifier,
      child: Consumer<ModifierWithCategory>(
        builder: (context, value, child) => FutureBuilder(
          future: getProductsByCategory,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ProductListItem(
                  product: snapshot.data![index],
                  modifier: modifier,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
