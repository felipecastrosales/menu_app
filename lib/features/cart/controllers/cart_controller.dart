import 'dart:collection';

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

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  int get productCount => _products.length;
  double get totalPrice => _products.fold(
        0,
        (previousValue, product) => previousValue + product.total,
      );

  String userName = '';
  String userPhone = '';

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void setUserPhone(String phone) {
    userPhone = phone;
    notifyListeners();
  }

  bool get isFormValid =>
      userName.length > 3 && userPhone.length > 9 && !loading;

  bool loading = false;

  Future<void> sendOrder() async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    loading = false;
    notifyListeners();
  }
}
