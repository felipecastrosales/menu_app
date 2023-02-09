import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:menu/core/widgets/core_back_button.dart';
import 'package:menu/core/widgets/core_elevated_button.dart';
import 'package:menu/core/widgets/core_page_title.dart';
import 'package:menu/core/widgets/core_text_field.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/pages/cart/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import 'cart_page_actions.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> implements CartPageActions {
  late final CartController cartController;

  @override
  void goToHome() {
    context.push('/menu');
  }

  @override
  void initState() {
    super.initState();
    cartController = context.read<CartController>();
    cartController.setActions(this);
  }

  @override
  void dispose() {
    cartController.setActions(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 24, bottom: 90),
            children: [
              Row(
                children: const [
                  SizedBox(width: 24),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CoreBackButton(),
                  ),
                  Expanded(
                    child: CorePageTitle(
                      title: 'Carrinho',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 24, right: 16),
                itemCount: cartController.products.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    product: cartController.products[index],
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
                  'Finalizar por ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(cartController.totalPrice)}',
              onPressed: cartController.products.isNotEmpty
                  ? () {
                      showUserInfoDialog(
                        context,
                        cartController,
                      );
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  void showUserInfoDialog(BuildContext context, CartController cartController) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: const Color(0xff212730),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Quase lá',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Precisamos fazer um pouco sobre você para finalizar seu pedido.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: cartController.userName,
                  title: 'Nome',
                  hint: 'Ex: João da Silva',
                  textInputType: TextInputType.name,
                  onChanged: cartController.setUserName,
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: cartController.userPhone,
                  title: 'Telefone',
                  hint: 'Ex: (11) 99999-9999',
                  textInputType: TextInputType.phone,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  onChanged: cartController.setUserPhone,
                ),
                const SizedBox(height: 32),
                Consumer<CartController>(
                  builder: (_, __, ___) {
                    return CoreElevatedButton(
                      title: 'Enviar pedido',
                      onPressed: cartController.isFormValid
                          ? () {
                              cartController.sendOrder();
                              Navigator.of(context).pop();
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
