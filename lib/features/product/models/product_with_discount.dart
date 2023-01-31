import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'modifier_item.dart';
import 'product.dart';

class ProductWithDiscount extends Equatable implements ModifierItem {
  const ProductWithDiscount({
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

  @override
  num get totalPrice => product.basePrice * (1 - discountPercentage / 100);

  @override
  List<Object?> get props => [product.id, discountPercentage];
}
