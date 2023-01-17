import 'package:flutter/material.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';

import 'modifier_info.dart';

class Modifier {
  Modifier({
    required this.info,
  });

  static Modifier? fromJson(Map<String, dynamic> json) {
    try {
      switch (json['__component']) {
        case 'product.modifier':
          return SimpleModifier.fromJson(json);
        case 'product.modificador-com-produto':
          return ModifierWithProducts.fromJson(json);
        case 'product.modificador-com-categoria':
          return ModifierWithCategory.fromJson(json);
        default:
          return null;
      }
    } catch (e, s) {
      debugPrint('Error parsing Modifier: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }

  final ModifierInfo info;

  @override
  String toString() => 'Modifier(info: $info)';
}
