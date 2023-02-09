import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/cart/pages/cart/widgets/cart_item_summary.dart';
import 'package:provider/provider.dart';

class HomeCartDrawer extends StatelessWidget {
  const HomeCartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return SizedBox(
      width: 102,
      child: Drawer(
        child: Stack(
          children: [
            LiveList.options(
              options: const LiveOptions(
                delay: Duration.zero,
                showItemInterval: Duration(milliseconds: 50),
                showItemDuration: Duration(milliseconds: 250),
                visibleFraction: 0.05,
                reAnimateOnVisibility: false,
              ),
              padding: const EdgeInsets.only(),
              itemCount: cartController.productCount,
              itemBuilder: (context, index, animation) {
                final product = cartController.products[index];
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: CartItemSummary(
                    product: product,
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 102 + MediaQuery.of(context).padding.top,
                width: 102,
                decoration: BoxDecoration(
                  color: Theme.of(context).drawerTheme.backgroundColor,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [.5, 1],
                    colors: [
                      Theme.of(context).drawerTheme.backgroundColor!,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 102,
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).drawerTheme.backgroundColor,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [.5, 1],
                    colors: [
                      Theme.of(context).drawerTheme.backgroundColor!,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${cartController.productCount} ${cartController.productCount == 1 ? 'item' : 'itens'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Total:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                      ).format(
                        cartController.totalPrice,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (cartController.productCount > 0) ...[
                      SizedBox.square(
                        dimension: 54,
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                          child: InkWell(
                            onTap: () {
                              context.push('/checkout');
                            },
                            borderRadius: BorderRadius.circular(27),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
