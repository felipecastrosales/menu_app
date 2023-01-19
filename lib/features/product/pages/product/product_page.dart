import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menu/core/widgets/core_back_button.dart';
import 'package:menu/features/product/models/product.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

import 'widgets/modifier_widget.dart';

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
  final ProductRepository productRepository = ProductRepositoryStrapi();
  late final Future<Product> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = productRepository.getProduct(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product>(
        future: productFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            final product = snapshot.requireData;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 64),
                    child: Align(
                      alignment: Alignment.centerLeft,
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
                          clipper: MyClipper(
                            borderRadius: .1,
                            angle: degToRad(80),
                          ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'A partir de ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(product.basePrice)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.originalBasePrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            NumberFormat.currency(
                              locale: 'pt_BR',
                              symbol: 'R\$',
                            ).format(product.originalBasePrice!),
                            style: const TextStyle(
                              color: Color(0xff5f6066),
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  for (final modifier in product.modifiers) ...[
                    ModifierWidget(modifier: modifier),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
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
