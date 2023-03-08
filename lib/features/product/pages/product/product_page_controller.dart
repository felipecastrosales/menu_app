import 'package:get/get.dart';

import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

class ProductPageController extends GetxController {
  ProductPageController({
    required this.id,
    ProductRepository? productRepository,
  }) : productRepository = productRepository ?? Get.find();

  final int id;

  final ProductRepository productRepository;

  final Rxn<Product> product = Rxn<Product>();

  Future<void> getProduct() async {
    final result = await productRepository.getProduct(id);

    if (result.isRight) {
      product.value = result.right;
    } else {
      switch (result.left) {
        case GetProductError.notFound:
          break;
        case GetProductError.unknown:
          break;
      }
    }
  }

  num? get total => product.value?.total;
  bool get isValid => !product.value!.modifiers.any((m) => !m.isValid);
}
