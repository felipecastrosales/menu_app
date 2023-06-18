import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:menu/core/routes/app_routes.dart';

class CoreBackButton extends StatelessWidget {
  const CoreBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: const Color(0xff393c44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      child: InkWell(
        onTap: () => Get.routing.isBack == true
            ? Get.back(canPop: true)
            : Get.toNamed(AppRoutes.scan.path),
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
