import 'package:flutter/material.dart';

import 'modifier_item.dart';
import 'product.dart';

class ProductWithDiscount implements ModifierItem {
  ProductWithDiscount({
    required this.product,
    required this.discountPercentage,
  });

  static ProductWithDiscount? fromJson(Map<String, dynamic> json) {
    try {
      return ProductWithDiscount(
        product: Product.fromJson(json['product']['data'])!,
        discountPercentage: json['discountPercentage'],
      );
    } catch (e, s) {
      debugPrint('Error parsing ProductWithDiscount: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }

  final Product product;
  final num discountPercentage;
}
