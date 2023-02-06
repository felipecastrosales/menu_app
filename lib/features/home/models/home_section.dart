import 'package:flutter/foundation.dart';
import 'package:menu/features/home/models/home_banner_section.dart';
import 'package:menu/features/home/models/home_menu_button_section.dart';
import 'package:menu/features/home/models/home_products_carousel_section.dart';
import 'package:menu/features/home/models/home_products_listing_section.dart';

abstract class HomeSection {
  static HomeSection? fromJson(Map<String, dynamic> json) {
    try {
      switch (json['__component']) {
        case 'core.banner':
          return HomeBannerSection.fromJson(json);
        case 'home.carrossel-de-produtos':
          return HomeProductsCarouselSection.fromJson(json);
        case 'home.botao-menu':
          return HomeMenuButtonSection.fromJson(json);
        case 'menu.listagem-por-categoria':
          return HomeProductsListingSection.fromJson(json);
        default:
          return null;
      }
    } catch (e, s) {
      debugPrint('Error parsing HomeSection: $e');
      debugPrint('StackTrace: $s');
      return null;
    }
  }

  HomeSection? copyFiltered(String search);
}
