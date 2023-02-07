import 'package:flutter/material.dart';
import 'package:menu/features/product/models/product.dart';

class CartController extends ChangeNotifier {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  int get productCount => _products.length;
  double get totalPrice => _products.fold(
        0,
        (previousValue, product) => previousValue + product.total,
      );
}
