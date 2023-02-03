import 'package:flutter/cupertino.dart';

import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

class ProductPageController extends ChangeNotifier {
  ProductPageController({
    required this.id,
  });

  final int id;

  final ProductRepository productRepository = StrapiProductRepository();

  Product? product;

  Future<void> getProduct() async {
    product = await productRepository.getProduct(id);
    if (product != null) {
      for (final modifier in product!.modifiers) {
        modifier.addListener(notifyListeners);
      }
    }
    notifyListeners();
  }

  num? get total => product?.total;
  bool get isValid =>
      product != null && !product!.modifiers.any((m) => !m.isValid);

  @override
  void dispose() {
    if (product != null) {
      for (final modifier in product!.modifiers) {
        modifier.removeListener(notifyListeners);
      }
    }
    super.dispose();
  }
}
