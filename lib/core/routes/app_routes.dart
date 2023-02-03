import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:menu/features/home/pages/home/home_page.dart';
import 'package:menu/features/product/pages/product/product_page.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
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
  ],
);
