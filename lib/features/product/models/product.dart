import 'package:flutter/material.dart';

import 'package:menu/features/product/models/category.dart';
import 'package:menu/features/product/models/modifier.dart';

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.originalBasePrice,
    required this.basePrice,
    required this.imageUrl,
    required this.category,
    required this.modifiers,
  });

  static Product? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    try {
      final attributes = json['attributes'];
      return Product(
        id: json['id'],
        title: attributes['title'],
        description: attributes['description'],
        originalBasePrice: attributes['originalBasePrice'],
        basePrice: attributes['basePrice'],
        imageUrl: attributes['image']['data']['attributes']['url'],
        category: Category.fromJson(attributes['data']),
        modifiers: List<Modifier>.from(
          attributes['options']
              .map<Modifier?>(
                (modifier) => Modifier.fromJson(modifier),
              )
              .where((modifier) => modifier != null)
              .toList(),
        ),
      );
    } catch (e, s) {
      debugPrint('Error parsing product: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }

  final int id;
  final String title;
  final String description;
  final num? originalBasePrice;
  final num basePrice;
  final String imageUrl;
  final Category? category;
  final List<Modifier> modifiers;

  @override
  String toString() {
    return 'Product(id: $id, title: $title, basePrice: $basePrice, modifiers: $modifiers)';
  }
}
