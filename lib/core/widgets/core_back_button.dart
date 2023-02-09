import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoreBackButton extends StatelessWidget {
  const CoreBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSize = 42.0;

    return Material(
      color: const Color(0xFF393c44),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonSize / 2),
      ),
      child: InkWell(
        onTap: () {
          context.canPop() ? context.pop() : context.push('/menu');
        },
        child: const SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
