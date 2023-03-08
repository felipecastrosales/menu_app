import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';

import 'package:menu/features/cart/pages/cart/cart_page.dart';
import 'package:menu/features/home/pages/home/home_page.dart';
import 'package:menu/features/product/pages/product/product_page.dart';
import 'package:menu/features/product/pages/product/product_page_bindings.dart';
import 'package:menu/features/scan/pages/scan/scan_page.dart';

enum AppRoutes {
  menu('/menu'),
  scan('/'),
  products('/products/:pid'),
  checkout('/checkout');

  const AppRoutes(this.path);

  final String path;
}

final appPages = [
  GetPage(
    name: AppRoutes.scan.path,
    page: () => const ScanPage(),
  ),
  GetPage(
    name: AppRoutes.menu.path,
    page: () => HomePage(
      table: Get.parameters['table'],
    ),
  ),
  GetPage(
    name: AppRoutes.products.path,
    binding: ProductPageBindings(),
    page: () {
      final id = int.tryParse(Get.parameters['pid'] ?? '');
      return id != null ? ProductPage(id: id) : const SizedBox();
    },
  ),
  GetPage(
    name: AppRoutes.checkout.path,
    page: () => const CartPage(),
  ),
];

void routingCallback(Routing? route) {
  if (route == null) return;
  final CartController cartController = Get.find();
  if (route.current == AppRoutes.checkout.path &&
      cartController.products.isEmpty) {
    Future.delayed(Duration.zero, () {
      Get.offNamed(AppRoutes.menu.path);
    });
  } else if (route.current != AppRoutes.scan.path &&
      cartController.table.value == null &&
      !Get.parameters.containsKey('table') &&
      route.previous != AppRoutes.scan.path) {
    Future.delayed(Duration.zero, () {
      Get.toNamed(AppRoutes.scan.path);
    });
  }

  if (route.current == AppRoutes.checkout.path &&
      cartController.products.isEmpty) {
    Get.offNamed(AppRoutes.menu.path);
  } else if (route.current != AppRoutes.scan.path &&
      cartController.table.value == null &&
      !Get.parameters.containsKey('table') &&
      route.previous != AppRoutes.scan.path) {
    Get.offNamed(AppRoutes.scan.path);
  }
}

// redirect: (context, state) {
//   final CartController cartController = context.read();
//   if (state.subloc == '/checkout' && cartController.products.isEmpty) {
//     return '/menu';
//   } else if (state.subloc != AppRoutes.scan.path &&
//       cartController.table == null &&
//       !state.queryParams.containsKey('table')) {
//     return AppRoutes.scan.path;
//   }
//   return null;
// },
