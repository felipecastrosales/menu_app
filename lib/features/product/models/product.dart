import 'package:equatable/equatable.dart';

import 'package:menu/features/product/models/category.dart';
import 'package:menu/features/product/models/modifier.dart';

class Product extends Equatable {
  const Product({
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
      final attr = json['attributes'];
      return Product(
        id: json['id'],
        title: attr['title'],
        description: attr['description'],
        originalBasePrice: attr['originalBasePrice'],
        basePrice: attr['basePrice'],
        imageUrl:
            'http://localhost:1338${attr['image']['data']['attributes']['url']}',
        category: Category.fromJson(attr['data']),
        modifiers: List<Modifier>.from(
          attr['options']
              .map<Modifier?>((modifier) => Modifier.fromJson(modifier))
              .where((m) => m != null)
              .toList(),
        ),
      );
    } catch (e) {
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

  num get total =>
      basePrice +
      modifiers.fold(
        0,
        (previousValue, element) => previousValue + element.total,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        originalBasePrice,
        basePrice,
        imageUrl,
        category,
        modifiers,
      ];

  @override
  bool get stringify => true;
}
