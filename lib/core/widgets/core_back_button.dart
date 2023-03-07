import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoreBackButton extends StatelessWidget {
  const CoreBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff393c44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.routing.isBack == true ? Get.back() : Get.toNamed('/'),
        child: const SizedBox(
          width: 42,
          height: 42,
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
