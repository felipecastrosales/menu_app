import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/pages/cart/cart_page.dart';

import 'package:menu/features/home/pages/home/home_page.dart';
import 'package:menu/features/product/pages/product/product_page.dart';
import 'package:menu/features/scan/pages/scan/scan_page.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/menu',
  redirect: (context, state) {
    final cartController = context.read<CartController>();
    if (state.subloc == '/checkout' && cartController.products.isEmpty) {
      return '/menu';
    } else if (state.subloc != '/scan' &&
        cartController.table == null &&
        !state.queryParams.containsKey('table')) {
      return '/scan';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/menu',
      builder: (context, state) => HomePage(
        table: state.queryParams['table'],
      ),
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final id = int.tryParse(state.params['id'] ?? '');
        return id == null ? const SizedBox() : ProductPage(id: id);
      },
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanPage(),
    ),
  ],
);

// TODO
enum AppRoutesEnum {
  menu('/menu'),
  product('/products'),
  checkout('/checkout');

  const AppRoutesEnum(this.path);

  final String path;
}
