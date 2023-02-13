import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/pages/cart/cart_page.dart';
import 'package:menu/features/home/pages/home/home_page.dart';
import 'package:menu/features/product/pages/product/product_page.dart';
import 'package:menu/features/scan/pages/scan/scan_page.dart';

enum AppRoutes {
  menu('/menu'),
  scan('/'),
  products('/products'),
  checkout('/checkout');

  const AppRoutes(this.path);

  final String path;
}

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.scan.path,
      builder: (context, state) => const ScanPage(),
    ),
    GoRoute(
      path: AppRoutes.menu.path,
      builder: (context, state) => HomePage(
        table: state.queryParams['table'],
      ),
    ),
    GoRoute(
      path: '${AppRoutes.products.path}/:id',
      builder: (context, state) {
        final id = int.tryParse(state.params['id'] ?? '');
        return id == null ? Container() : ProductPage(id: id);
      },
    ),
    GoRoute(
      path: AppRoutes.checkout.path,
      builder: (context, state) => const CartPage(),
    ),
  ],
  initialLocation: AppRoutes.scan.path,
  redirect: (context, state) {
    final CartController cartController = context.read();
    if (state.subloc == '/checkout' && cartController.products.isEmpty) {
      return '/menu';
    } else if (state.subloc != AppRoutes.scan.path &&
        cartController.table == null &&
        !state.queryParams.containsKey('table')) {
      return AppRoutes.scan.path;
    }
    return null;
  },
);
