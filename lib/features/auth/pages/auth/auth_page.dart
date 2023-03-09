import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu/core/routes/app_routes.dart';
import 'package:menu/core/widgets/core_elevated_button.dart';
import 'package:menu/core/widgets/core_text_field.dart';
import 'package:menu/features/auth/datasources/strapi_auth_datasource.dart';

import 'auth_page_actions.dart';
import 'auth_page_controller.dart';

class AuthPage extends StatelessWidget implements AuthPageActions {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final AuthPageController controller =
        Get.put(AuthPageController(this));

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.grey[900],
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Entre em sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                CoreTextField(
                  title: 'Usuário',
                  hint: 'Usuário',
                  onChanged: controller.setEmail,
                ),
                CoreTextField(
                  title: 'Senha',
                  hint: 'Senha',
                  onChanged: controller.setPassword,
                ),
                const SizedBox(height: 32),
                Obx(
                  () => CoreElevatedButton(
                    onPressed: controller.onLoginPressed,
                    title: 'Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void navToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard.path);
  }

  @override
  void showErrorMessage(
    LoginError error,
  ) {
    Get.snackbar(
      'Ocorreu um erro',
      error.message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }
}
