import 'package:flutter/material.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class HomeCartButton extends StatefulWidget {
  const HomeCartButton({
    super.key,
    required this.scaffoldKey,
    required this.isDrawerOpen,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDrawerOpen;

  @override
  State<HomeCartButton> createState() => _HomeCartButtonState();
}

class _HomeCartButtonState extends State<HomeCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation<Color?> colorAnimation = ColorTween(
    begin: Theme.of(context).primaryColor,
    end: const Color(0xff393c44),
  ).animate(animationController);

  late Animation<double> rotationAnimation = Tween<double>(
    begin: 1,
    end: .75,
  ).animate(animationController);

  late Animation<double> scaleAnimation = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 1, end: 0),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 0, end: 1),
      weight: 1,
    ),
  ]).animate(animationController);

  @override
  void didUpdateWidget(HomeCartButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDrawerOpen != widget.isDrawerOpen) {
      animationController.animateTo(widget.isDrawerOpen ? 1 : 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double distanceBetweenPurpleComponentAndFinalScreen = 24;

    return SizedBox(
      width: 54 + distanceBetweenPurpleComponentAndFinalScreen,
      height: 54,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 24,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, child) {
                return Material(
                  clipBehavior: Clip.antiAlias,
                  color: colorAnimation.value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(27),
                    onTap: () {
                      final scaffold = widget.scaffoldKey.currentState!;
                      if (scaffold.isDrawerOpen) {
                        scaffold.closeEndDrawer();
                      } else {
                        scaffold.openEndDrawer();
                      }
                    },
                    child: RotationTransition(
                      turns: rotationAnimation,
                      child: ScaleTransition(
                        scale: scaleAnimation,
                        child: Icon(
                          animationController.value < 0.5
                              ? Icons.shopping_cart_outlined
                              : Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: AnimatedContainer(
                alignment: Alignment.center,
                width: widget.isDrawerOpen ? 0 : 28,
                height: widget.isDrawerOpen ? 0 : 28,
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: widget.isDrawerOpen ? 14 : 0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Consumer<CartController>(
                  builder: (context, cartController, child) {
                    return Text(
                      '${cartController.productCount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
