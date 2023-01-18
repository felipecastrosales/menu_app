import 'package:flutter/material.dart';
import 'package:menu/features/product/pages/product/product_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Container(color: Colors.red),
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