import 'package:flutter/material.dart';

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
  late final Controller controller = Controller(id: widget.id);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building ProductPage with id: ${controller.id}');
    return const Placeholder();
  }
}

class Controller {
  Controller({
    required this.id,
  });

  final int id;
}
