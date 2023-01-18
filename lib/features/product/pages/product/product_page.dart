import 'package:flutter/material.dart';
import 'package:menu/features/product/repositories/product_repository.dart';

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
    return Column(
      children: [
        const Placeholder(),
        ElevatedButton(
          onPressed: () async {
            final repository = ProductRepository();
            final product = await repository.getProducts();
            debugPrint('Product: $product');
          },
          child: const Text('Add to cart'),
        ),
      ],
    );
  }
}

class Controller {
  Controller({
    required this.id,
  });

  final int id;
}
