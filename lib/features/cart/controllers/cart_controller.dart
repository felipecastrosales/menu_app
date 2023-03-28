import 'dart:collection';

import 'package:get/get.dart';

import 'package:menu/features/cart/models/create_order_model.dart';
import 'package:menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:menu/features/cart/repositories/cart_repository.dart';
import 'package:menu/features/product/models/product.dart';

class CartController extends GetxController {
  CartController({CartRepository? cartRepository, this.actions})
      : _cartRepository = cartRepository ?? Get.find();

  final RxList<Product> _products = RxList<Product>([]);
  final CartRepository _cartRepository;

  CartPageActions? actions;
  final Rxn<String> table = Rxn<String>();

  void setTable(String? t) {
    if (t == null) return;
    table.value = t;
  }

  void setActions(CartPageActions? actions) {
    this.actions = actions;
  }

  void addProduct(Product product) {
    _products.add(product);
  }

  void removeProduct(Product product) {
    _products.remove(product);
  }

  int get productCount => _products.length;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  double get totalPrice => _products.fold(
        0,
        (previousValue, product) => previousValue + product.total,
      );

  final RxString _userName = ''.obs;
  final RxString _userPhone = ''.obs;

  RxString get userName => _userName;
  RxString get userPhone => _userPhone;

  void setUserName(String t) {
    _userName.value = t;
  }

  void setUserPhone(String t) {
    _userPhone.value = t;
  }

  RxBool loading = false.obs;

  bool get isFormValid =>
      userName.value.length >= 4 &&
      userPhone.value.length >= 14 &&
      !loading.value;

  Future<void> sendOrder() async {
    loading.value = true;

    try {
      await _cartRepository.createOrder(
        CreateOrderModel(
          table: table.value!,
          products: _products,
          userName: userName.value,
          userPhone: userPhone.value,
        ),
      );
      _products.clear();
      actions?.goToHome();
    } catch (e) {
      actions?.showErrorMessage();
    }
    loading.value = false;
  }

  @override
  void dispose() {
    actions = null;
    super.dispose();
  }
}
