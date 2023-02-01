import 'package:flutter/material.dart';

import 'home_section.dart';

enum HomeBannerSize {
  small,
  big,
}

class HomeBannerSection extends HomeSection {
  HomeBannerSection({
    required this.title,
    required this.size,
    required this.imageUrl,
    required this.productId,
  });

  final String title;
  final HomeBannerSize size;
  final String imageUrl;
  final int productId;

  static HomeBannerSection? fromJson(Map<String, dynamic> json) {
    try {
      return HomeBannerSection(
        title: json['title'],
        size: HomeBannerSize.values.byName(json['size']),
        imageUrl:
            'http://localhost:1337${json['image']['data']['attributes']['formats']['thumbnail']['url']}',
        productId: json['product']['data']['id'],
      );
    } catch (e, s) {
      debugPrint('Error parsing Modifier: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }
}
