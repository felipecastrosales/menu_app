import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:menu/features/cart/models/order.dart';
import 'package:menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/product/models/product.dart';

class CartController extends ChangeNotifier {
  final List<Product> _products = [];
  final CartRepository _cartRepository = CartRepository();

  CartPageActions? actions;
  void setActions(CartPageActions? actions) {
    this.actions = actions;
  }

  String? table;
  void setTable(String? t) {
    t = table;
  }

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
      userName.length > 4 && userPhone.length > 14 && !loading;

  bool loading = false;

  Future<void> sendOrder() async {
    loading = true;
    notifyListeners();
    _cartRepository.createOrder(
      Order(
        table: table!,
        products: _products,
        userName: userName,
        userPhone: userPhone,
      ),
    );
    _products.clear();
    actions?.goToHome();
    loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    actions = null;
    super.dispose();
  }
}
