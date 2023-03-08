import 'package:menu/core/extensions/string_extension.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/product/models/product.dart';

class HomeProductsListingSection extends HomeSection {
  HomeProductsListingSection({required this.title, required this.products});

  static HomeProductsListingSection fromJson(Map<String, dynamic> json) {
    return HomeProductsListingSection(
      title: json['category']['data']['attributes']['title'],
      products: List<Product>.from(
        json['category']['data']['attributes']['products']['data']
            .map<Product?>((j) => Product.fromJson(j))
            .where((p) => p != null)
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
          (p) =>
              p.title.clear.contains(search) ||
              p.description.clear.contains(search),
        )
        .toList();
    if (filteredProducts.isEmpty) return null;
    return HomeProductsListingSection(
      title: title,
      products: filteredProducts,
    );
  }
}
