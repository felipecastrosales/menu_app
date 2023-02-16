import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:menu/core/injections/injections.dart';

import 'package:menu/features/cart/models/order.dart';
import 'package:menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/product/models/product.dart';

class CartController extends ChangeNotifier {
  CartController({CartRepository? cartRepository, this.actions})
      : _cartRepository = cartRepository ?? getIt();

  final List<Product> _products = [];
  final CartRepository _cartRepository;

  CartPageActions? actions;

  String? table;

  void setTable(String? t) {
    if (t == null) return;
    table = t;
  }

  void setActions(CartPageActions? actions) {
    this.actions = actions;
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  int get productCount => _products.length;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  double get totalPrice => _products.fold(
        0,
        (previousValue, product) => previousValue + product.total,
      );

  String _userName = '';
  String _userPhone = '';

  String get userName => _userName;
  String get userPhone => _userPhone;

  void setUserName(String t) {
    _userName = t;
    notifyListeners();
  }

  void setUserPhone(String t) {
    _userPhone = t;
    notifyListeners();
  }

  bool loading = false;

  bool get isFormValid =>
      userName.length >= 4 && userPhone.length >= 14 && !loading;

  Future<void> sendOrder() async {
    loading = true;
    notifyListeners();

    try {
      await _cartRepository.createOrder(
        Order(
          table: table!,
          products: _products,
          userName: userName,
          userPhone: userPhone,
        ),
      );
      _products.clear();
      actions?.goToHome();
    } catch (e) {
      actions?.showErrorMessage();
    }
    loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    actions = null;
    super.dispose();
  }
}
