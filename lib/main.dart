import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:menu/core/routes/app_routes.dart';

import 'core/injections/injections.dart';

void main() {
  runApp(const MenuApp());
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.scan.path,
      getPages: appPages,
      initialBinding: CoreBindings(),
      title: 'Felipo\'s Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1f2027),
        primaryColor: const Color(0xff7a3dff),
        textTheme: GoogleFonts.latoTextTheme(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff7a3dff),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: const Color(0xff1f2027).withOpacity(0.9),
        ),
      ),
      routingCallback: routingCallback,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: ColoredBox(
            color: const Color(0xff1f2027),
            child: Align(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff7a3dff).withOpacity(0.4),
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: const Color(0xff7a3dff).withOpacity(0.4),
                      offset: const Offset(-4, 4),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: child!,
              ),
            ),
          ),
        );
      },
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
