import 'package:flutter/material.dart';
import 'package:menu/core/routes/app_routes.dart';

void main() {
  runApp(
    const MenuApp(),
  );
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xff1f2027),
        primaryColor: const Color(0xff7a3dff),
      ),
      routerConfig: router,
    );
  }
}
