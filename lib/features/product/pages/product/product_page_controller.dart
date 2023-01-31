import 'package:flutter/material.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

class ProductPageController extends ChangeNotifier {
  ProductPageController({
    required this.id,
  });

  final int id;
  final ProductRepository _productRepository = StrapiProductRepository();

  Product? product;

  Future<void> getProduct() async {
    product = await _productRepository.getProduct(id);
    if (product != null) {
      for (var modifier in product?.modifiers ?? []) {
        modifier.addListener(notifyListeners);
      }
    }
    notifyListeners();
  }

  num? get totalPrice => product?.totalPrice;

  bool get isValid =>
      product != null &&
      !product!.modifiers.any((modifier) => !modifier.isValid);

  @override
  void dispose() {
    if (product != null) {
      for (var modifier in product?.modifiers ?? []) {
        modifier.removeListener(notifyListeners);
      }
    }
    super.dispose();
  }
}
