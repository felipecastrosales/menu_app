import 'package:flutter/material.dart';
import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';

class ModifierWidget extends StatelessWidget {
  const ModifierWidget({
    super.key,
    required this.modifier,
  });

  final Modifier modifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ModifierHeader(modifier: modifier),
        Builder(
          builder: (_) {
            if (modifier is SimpleModifier) {
              // return SimpleModifierWidget();
              return const SizedBox();
            } else if (modifier is ModifierWithProducts) {
              // return ModifierWithProductsWidget();
              return const SizedBox();
            } else if (modifier is ModifierWithCategory) {
              // return ModifierWithCategoryWidget();
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

class ModifierHeader extends StatelessWidget {
  const ModifierHeader({
    super.key,
    required this.modifier,
  });
  final Modifier modifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modifier.info.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Selecione uma opção',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Obrigatório',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
