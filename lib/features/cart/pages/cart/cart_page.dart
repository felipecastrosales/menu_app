import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:menu/core/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'package:menu/core/widgets/core_back_button.dart';
import 'package:menu/core/widgets/core_elevated_button.dart';
import 'package:menu/core/widgets/core_page_title.dart';
import 'package:menu/core/widgets/core_text_field.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:menu/features/cart/pages/cart/widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> implements CartPageActions {
  late final CartController controller;

  @override
  Widget build(BuildContext context) {
    final CartController controller = context.watch();

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 24, bottom: 90),
            children: [
              Row(
                children: const [
                  SizedBox(width: 24),
                  CoreBackButton(),
                  Expanded(child: CorePageTitle(title: 'Carrinho')),
                ],
              ),
              const SizedBox(height: 32),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 24, right: 16),
                itemCount: controller.productCount,
                itemBuilder: (_, i) {
                  final product = controller.products[i];
                  return CartItem(
                    product: product,
                  );
                },
              ),
            ],
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: CoreElevatedButton(
              title:
                  'Finalizar por ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.totalPrice)}',
              onPressed: controller.products.isNotEmpty
                  ? () {
                      showUserInfoDialog(context);
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  void showUserInfoDialog(BuildContext context) {
    final CartController cartController = context.read();

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: const Color(0xff212730),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Quase lá!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Precisamos saber um pouco sobre você para finalizar seu pedido...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                CoreTextField(
                  initialValue: cartController.userName.value,
                  title: 'Nome',
                  hint: 'Seu nome',
                  textInputType: TextInputType.name,
                  onChanged: cartController.setUserName,
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: cartController.userPhone.value,
                  title: 'Celular',
                  hint: '(99) 91234-5678',
                  textInputType: TextInputType.phone,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  onChanged: cartController.setUserPhone,
                ),
                const SizedBox(height: 32),
                Obx(
                  () => CoreElevatedButton(
                    onPressed: cartController.isFormValid
                        ? cartController.sendOrder
                        : null,
                    title: 'Enviar pedido',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void goToHome() {
    Get.toNamed(AppRoutes.menu.path);
  }

  @override
  void initState() {
    super.initState();
    controller = context.read();
    controller.setActions(this);
  }

  @override
  void dispose() {
    controller.setActions(null);
    super.dispose();
  }

  @override
  void showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erro ao enviar pedido'),
      ),
    );
  }
}
