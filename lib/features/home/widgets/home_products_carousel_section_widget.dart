import 'package:flutter/material.dart';

import 'package:menu/features/home/models/home_products_carousel_section.dart';
import 'package:menu/features/product/widgets/product_card.dart';

class HomeProductsCarouselSectionWidget extends StatelessWidget {
  const HomeProductsCarouselSectionWidget({
    super.key,
    required this.section,
  });

  final HomeProductsCarouselSection section;

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
        SizedBox(
          height: 210,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return ProductCard(
                product: section.products[i],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              width: 12,
            ),
            itemCount: section.products.length,
          ),
        ),
      ],
    );
  }
}
