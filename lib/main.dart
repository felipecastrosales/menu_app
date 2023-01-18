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
      ),
      routerConfig: router,
    );
  }
}
