import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menu/core/widgets/core_back_button.dart';
import 'package:menu/core/widgets/core_elevated_button.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/product/pages/product/product_page_controller.dart';
import 'package:menu/features/product/pages/product/widgets/modifier_widget.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductPageController controller =
      ProductPageController(id: widget.id);

  @override
  void initState() {
    super.initState();
    controller.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Scaffold(
        body: Consumer<ProductPageController>(
          builder: (context, controller, child) {
            if (controller.product == null) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white,
                  size: 50,
                ),
              );
            } else {
              final product = controller.product!;

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(24, 24, 24, 64),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CoreBackButton(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ClipPath(
                                  clipper: MyClipper(),
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    height: 200,
                                    color: const Color(0xff212730),
                                  ),
                                ),
                              ),
                              ClipPath(
                                clipper: MyClipper(),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  product.imageUrl,
                                  height: 200,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 52,
                            vertical: 32,
                          ),
                          child: Text(
                            product.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 52),
                          child: Text(
                            product.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'A partir de ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(product.basePrice)}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (product.originalBasePrice != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  NumberFormat.simpleCurrency(locale: 'pt_BR')
                                      .format(product.originalBasePrice),
                                  style: const TextStyle(
                                    color: Color(0xff5f6066),
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        for (final modifier in product.modifiers)
                          ModifierWidget(modifier: modifier),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: CoreElevatedButton(
                      title:
                          'Adicionar por ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.total)}',
                      onPressed: controller.isValid
                          ? () {
                              final cartController =
                                  context.read<CartController>();
                              cartController.addProduct(product);
                              context.push('/');
                            }
                          : null,
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MyClipper extends CustomClipper<Path> {
  final double _borderRadius;
  final double _angle;

  MyClipper({
    double? borderRadius,
    double? angle,
  })  : _borderRadius = borderRadius ?? .1,
        _angle = angle ?? degToRad(80);

  @override
  Path getClip(Size size) {
    final borderRadius = _borderRadius * size.shortestSide;
    final dx = borderRadius * cos(_angle);
    final dy = borderRadius * sin(_angle);
    final dX = size.height / tan(_angle);
    Path path = Path()
      ..moveTo(borderRadius, size.height)
      ..quadraticBezierTo(0, size.height, dx, size.height - dy)
      ..lineTo(dX - dx, dy)
      ..quadraticBezierTo(dX, 0, dX + borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width - dx, dy)
      ..lineTo(size.width - dX + dx, size.height - dy)
      ..quadraticBezierTo(size.width - dX, size.height,
          size.width - dX - borderRadius, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

double degToRad(double deg) => deg * (pi / 180.0);
