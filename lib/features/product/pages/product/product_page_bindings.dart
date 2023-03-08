import 'package:get/get.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

class ProductPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => StrapiProductRepository(Get.find()));
  }
}
