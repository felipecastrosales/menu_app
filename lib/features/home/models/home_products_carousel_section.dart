import 'package:menu/core/extensions/string_extension.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/product/models/product.dart';

class HomeProductsCarouselSection extends HomeSection {
  HomeProductsCarouselSection({
    required this.title,
    required this.products,
  });

  static HomeProductsCarouselSection fromJson(Map<String, dynamic> json) {
    return HomeProductsCarouselSection(
      title: json['category']['data']['attributes']['title'],
      products: List<Product>.from(
        json['category']['data']['attributes']['products']['data']
            .map<Product?>((json) => Product.fromJson(json))
            .where((product) => product != null)
            .toList(),
      ),
    );
  }

  final String title;
  final List<Product> products;

  @override
  HomeSection? copyFiltered(String search) {
    final filteredProducts = products
        .where(
          (product) =>
              product.title.clear.contains(search) ||
              product.description.clear.contains(search),
        )
        .toList();
    if (filteredProducts.isEmpty) return null;
    return HomeProductsCarouselSection(
      title: title,
      products: filteredProducts,
    );
  }
}
