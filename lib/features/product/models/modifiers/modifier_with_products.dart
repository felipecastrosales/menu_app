import 'package:menu/features/product/models/modifier.dart';
import 'package:menu/features/product/models/modifier_info.dart';
import 'package:menu/features/product/models/product.dart';

class ModifierWithProducts extends Modifier {
  ModifierWithProducts({
    required super.info,
    required this.products,
  });

  ModifierWithProducts.fromJson(Map<String, dynamic> json)
      : products = json['products']
            .map<Product?>((product) => Product.fromJson(product))
            .toList()
            .clear,
        super(
          info: ModifierInfo.fromJson(json['info']),
        );

  final List<Product> products;
}
