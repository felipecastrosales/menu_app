import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:menu/features/cart/pages/cart/cart_page.dart';
import 'package:menu/features/home/pages/home/home_page.dart';
import 'package:menu/features/product/pages/product/product_page.dart';
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
    page: () {
      final id = int.tryParse(Get.parameters['pid'] ?? '');
      return id != null ? ProductPage(id: id) : const SizedBox();
    },
  ),
  GetPage(name: AppRoutes.checkout.path, page: () => const CartPage()),
];

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