import 'package:flutter/material.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/product/models/product.dart';

class HomeProductsCarouselSection extends HomeSection {
  HomeProductsCarouselSection({
    required this.title,
    required this.products,
  });

  final String title;
  final List<Product> products;

  static HomeProductsCarouselSection? fromJson(Map<String, dynamic> json) {
    try {
      return HomeProductsCarouselSection(
        title: json['category']['data']['attributes']['title'],
        products: List<Product>.from(
          json['category']['data']['attributes']['products']['data']
              .map<Product?>((j) => Product.fromJson(j))
              .where((p) => p != null)
              .toList(),
        ),
      );
    } catch (e, s) {
      debugPrint('Error parsing Modifier: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }
}
