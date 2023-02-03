import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_info.dart';
import 'package:menu/features/product/models/product_with_discount.dart';

class ModifierWithProducts extends Modifier {
  ModifierWithProducts({required super.info, required this.products});

  ModifierWithProducts.fromJson(Map<String, dynamic> json)
      : products = List<ProductWithDiscount>.from(json['products']
            .map<ProductWithDiscount?>((p) => ProductWithDiscount.fromJson(p))
            .where((p) => p != null)
            .toList()),
        super(
          info: ModifierInfo.fromJson(json['info']),
        );

  final List<ProductWithDiscount> products;
}
