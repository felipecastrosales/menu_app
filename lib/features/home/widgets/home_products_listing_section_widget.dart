import 'package:flutter/material.dart';

import 'package:menu/features/home/models/home_products_listing_section.dart';
import 'package:menu/features/product/widgets/horizontal_product_card.dart';

class HomeProductsListingSectionWidget extends StatelessWidget {
  const HomeProductsListingSectionWidget({
    super.key,
    required this.section,
  });

  final HomeProductsListingSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Text(
            section.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemBuilder: (_, i) {
            return HorizontalProductCard(
              product: section.products[i],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 8,
          ),
          itemCount: section.products.length,
        ),
      ],
    );
  }
}
