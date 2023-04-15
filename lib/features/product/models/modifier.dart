import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import 'package:menu/features/product/models/modifier_info.dart';
import 'package:menu/features/product/models/modifier_item.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_category.dart';
import 'package:menu/features/product/models/modifiers/modifier_with_products.dart';
import 'package:menu/features/product/models/modifiers/simple_modifier.dart';

abstract class Modifier extends GetxController {
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
      debugPrint('$e $s');
      return null;
    }
  }

  final ModifierInfo info;

  final RxList<ModifierItem> _selectedOptions = RxList([]);

  UnmodifiableListView<ModifierItem> get selectedOptions =>
      UnmodifiableListView(_selectedOptions);

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

  int countOption(ModifierItem option) {
    return _selectedOptions.where((e) => e == option).length;
  }

  bool get canAddItem =>
      info.maxQuantity == null || _selectedOptions.length < info.maxQuantity!;

  bool get isValid =>
      info.minQuantity <= _selectedOptions.length &&
      (info.maxQuantity == null ||
          _selectedOptions.length <= info.maxQuantity!);

  num get total {
    num t = 0;
    for (final option in _selectedOptions) {
      t += option.total;
    }
    return t;
  }

  @override
  String toString() => 'Modifier(info: $info)';
}
