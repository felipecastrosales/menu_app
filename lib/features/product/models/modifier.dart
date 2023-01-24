import 'package:flutter/material.dart';

import 'package:menu/features/product/models/modifier_info.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';

import 'modifier_item.dart';

abstract class Modifier {
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
  final List<ModifierItem> _selectedOptions = [];

  void addItem(ModifierItem option) {
    if (_selectedOptions.contains(option)) {
      if (info.allowRepeated) {
        _selectedOptions.add(option);
      }
    } else {
      _selectedOptions.add(option);
    }
    if (info.maxQuantity == 1) {
      _selectedOptions.removeWhere((element) => element != option);
    }
  }

  void removeItem(ModifierItem option) {
    _selectedOptions.remove(option);
  }

  bool contains(ModifierItem option) {
    return _selectedOptions.contains(option);
  }

  @override
  String toString() => 'Modifier(info: $info)';
}
