import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:menu/core/routes/app_routes.dart';
import 'package:menu/core/widgets/core_elevated_button.dart';
import 'package:menu/core/widgets/core_text_field.dart';
import 'package:menu/features/auth/datasources/strapi_auth_datasource.dart';
import 'package:menu/features/auth/pages/auth/auth_page_actions.dart';
import 'package:menu/features/auth/pages/auth/auth_page_controller.dart';

class AuthPage extends StatelessWidget implements AuthPageActions {
  AuthPage({super.key});

  late final AuthPageController controller = Get.put(AuthPageController(this));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Entre em sua conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CoreTextField(
                    title: 'Usuário',
                    hint: 'Informe seu e-mail ou usuário',
                    onChanged: controller.setUsername,
                  ),
                  const SizedBox(height: 8),
                  CoreTextField(
                    title: 'Senha',
                    hint: 'Informe sua senha',
                    obscure: true,
                    onChanged: controller.setPassword,
                  ),
                  const SizedBox(height: 32),
                  Obx(() {
                    return CoreElevatedButton(
                      onPressed: controller.onLoginPressed,
                      title: 'Entrar',
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void navToDashboard() {
    Get.offNamed(AppRoutes.dashboard.path);
  }

  @override
  void showErrorMessage(LoginError error) {
    Get.snackbar(
      'Um erro ocorreu',
      error.message,
      backgroundColor: Colors.white,
    );
  }
}
