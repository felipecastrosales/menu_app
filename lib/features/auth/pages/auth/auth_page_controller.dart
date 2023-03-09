import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu/features/auth/repository/auth_repository.dart';

import 'auth_page_actions.dart';

class AuthPageController extends GetxController {
  final AuthRepository _repository = Get.find();
  AuthPageActions? _actions;

  AuthPageController(this._actions);

  final _username = RxString('');
  final _password = RxString('');

  void setEmail(String value) => _username.value = value;
  void setPassword(String value) => _password.value = value;

  bool get _isUsernameValid => _username.value.length >= 4;
  bool get _isPasswordValid => _password.value.length >= 4;
  bool get _isFormValid => _isUsernameValid && _isPasswordValid;
  VoidCallback? get onLoginPressed => _isFormValid ? login : null;

  @visibleForTesting
  Future<void> login() async {
    final result = await _repository.login(_username.value, _password.value);

    if (result.isLeft) {
      _actions?.showErrorMessage(result.left);
    } else {
      _actions?.navToDashboard();
    }
  }

  @override
  void onClose() {
    _actions = null;
    super.onClose();
  }
}
