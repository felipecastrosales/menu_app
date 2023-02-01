import 'package:flutter/material.dart';
import 'package:menu/features/home/models/home_banner_section.dart';

import 'home_products_carousel_section.dart';

class HomeSection {
  static HomeSection? fromJson(Map<String, dynamic> json) {
    try {
      switch (json['__component']) {
        case 'core.banner':
          return HomeBannerSection.fromJson(json);
        case 'home.carrossel-de-produtos':
          return HomeProductsCarouselSection.fromJson(json);
        default:
          return null;
      }
    } catch (e, s) {
      debugPrint('Error parsing Modifier: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }
}
