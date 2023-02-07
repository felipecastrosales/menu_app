import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu/core/routes/app_routes.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MenuApp(),
  );
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartController(),
      child: MaterialApp.router(
        title: 'Menu App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xff1f2027),
          primaryColor: const Color(0xff7a3dff),
          textTheme: GoogleFonts.latoTextTheme(),
          drawerTheme: DrawerThemeData(
            backgroundColor: const Color(0xff1f2027).withOpacity(0.9),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
