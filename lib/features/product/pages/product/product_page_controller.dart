import 'package:flutter/cupertino.dart';
import 'package:menu/core/injections/injections.dart';
import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

class ProductPageController extends ChangeNotifier {
  ProductPageController({required this.id});

  final int id;

  final ProductRepository productRepository = getIt();

  Product? product;

  Future<void> getProduct() async {
    final result = await productRepository.getProduct(id);

    if (result.isRight) {
      if (product != null) {
        for (final modifier in product!.modifiers) {
          modifier.addListener(notifyListeners);
        }
      }
      notifyListeners();
    } else {
      switch (result.left) {
        case GetProductError.notFound:
          break;
        case GetProductError.unknown:
          break;
      }
    }
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
