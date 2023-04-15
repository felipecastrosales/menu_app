import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:menu/core/injections/injections.dart';
import 'package:menu/core/routes/app_routes.dart';

void main() {
  runApp(const MenuApp());
}

class MenuApp extends StatefulWidget {
  const MenuApp({super.key});

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  bool limitWidth = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Felipo\'s Menu',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.scan.path,
      getPages: appPages,
      initialBinding: CoreBindings(),
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
      navigatorObservers: [CustomObserver(onRouteChanged: checkRoute)],
      builder: limitWidth
          ? (context, child) {
              return ColoredBox(
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
              );
            }
          : null,
    );
  }

  void checkRoute(String? route) {
    if (route == null) return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (route.startsWith(AppRoutes.dashboard.path)) {
        setState(() {
          limitWidth = false;
        });
      } else {
        setState(() {
          limitWidth = true;
        });
      }
    });
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

class CustomObserver extends RouteObserver<ModalRoute<dynamic>> {
  CustomObserver({required this.onRouteChanged});

  final Function(String?) onRouteChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onRouteChanged(route.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    onRouteChanged(newRoute?.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onRouteChanged(previousRoute?.settings.name);
  }
}
