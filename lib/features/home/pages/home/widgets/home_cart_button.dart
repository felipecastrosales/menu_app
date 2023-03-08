import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';

class HomeCartButton extends StatefulWidget {
  const HomeCartButton({
    Key? key,
    required this.scaffoldKey,
    required this.drawerOpen,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool drawerOpen;

  @override
  State<HomeCartButton> createState() => _HomeCartButtonState();
}

class _HomeCartButtonState extends State<HomeCartButton>
    with SingleTickerProviderStateMixin {
  final CartController cartController = Get.find();

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation<Color?> colorAnimation = ColorTween(
    begin: Theme.of(context).primaryColor,
    end: const Color(0xff393c44),
  ).animate(controller);

  late Animation<double> rotationAnimation =
      Tween<double>(begin: 1, end: 0.75).animate(controller);

  late Animation<double> scaleAnimation = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1),
  ]).animate(controller);

  @override
  void didUpdateWidget(HomeCartButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.drawerOpen != widget.drawerOpen) {
      controller.animateTo(widget.drawerOpen ? 1 : 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54 + 24,
      height: 54,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            top: 0,
            right: 24,
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, child) {
                return Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  clipBehavior: Clip.antiAlias,
                  color: colorAnimation.value,
                  child: InkWell(
                    onTap: () {
                      final scaffold = widget.scaffoldKey.currentState!;
                      if (scaffold.isEndDrawerOpen) {
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
                          controller.value < 0.5
                              ? Icons.shopping_cart_outlined
                              : Icons.close,
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
              type: MaterialType.transparency,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.drawerOpen ? 0 : 28,
                height: widget.drawerOpen ? 0 : 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(right: widget.drawerOpen ? 14 : 0),
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    cartController.productCount.toString(),
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
