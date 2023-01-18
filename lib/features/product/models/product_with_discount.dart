import 'package:flutter/material.dart';
import 'package:menu/features/product/models/product.dart';

class ProductWithDiscount {
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
