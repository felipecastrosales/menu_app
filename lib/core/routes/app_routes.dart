import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/pages/cart/cart_page.dart';

import 'package:menu/features/home/pages/home/home_page.dart';
import 'package:menu/features/product/pages/product/product_page.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  redirect: (context, state) {
    final cartController = context.read<CartController>();
    if (state.subloc == '/checkout' && cartController.products.isEmpty) {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
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
  ],
);
