import 'package:flutter/material.dart';
import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_with_category_widget.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_with_products_widget.dart';
import 'package:menu/features/product/pages/product/widgets/simple_modifier_widget.dart';
import 'package:provider/provider.dart';

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
              return ChangeNotifierProvider.value(
                value: modifier as SimpleModifier,
                child: const SimpleModifierWidget(),
              );
            } else if (modifier is ModifierWithProducts) {
              return ModifierWithProductsWidget(
                modifier: modifier as ModifierWithProducts,
              );
            } else if (modifier is ModifierWithCategory) {
              return ModifierWithCategoryWidget(
                modifier: modifier as ModifierWithCategory,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class ModifierHeader extends StatelessWidget {
  const ModifierHeader({Key? key, required this.modifier}) : super(key: key);

  final Modifier modifier;

  String getDescription() {
    final info = modifier.info;
    if (info.maxQuantity == null) {
      if (info.minQuantity == 0) {
        return 'Opcional';
      } else if (info.minQuantity == 1) {
        return 'Selecione ao menos uma opção';
      } else {
        return 'Selecione ao menos ${info.minQuantity} opções';
      }
    } else if (info.maxQuantity == 1) {
      if (info.minQuantity == 0) {
        return 'Selecione até uma opção';
      } else if (info.minQuantity == 1) {
        return 'Selecione uma opção';
      } else {
        return '';
      }
    } else {
      if (info.minQuantity == 0) {
        return 'Selecione até ${info.maxQuantity} opções';
      } else {
        return 'Selecione de 1 a ${info.maxQuantity} opções';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        color: Color(0xff2a2e3d),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modifier.info.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  getDescription(),
                  style: const TextStyle(
                    color: Colors.white60,
                  ),
                )
              ],
            ),
          ),
          if (modifier.info.minQuantity > 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(6),
              child: const Text(
                'Obrigatório',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
