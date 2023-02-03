import 'package:flutter/material.dart';
import 'package:menu/features/home/pages/home/home_page_controller.dart';
import 'package:menu/features/home/pages/home/tabs/home/home_tab.dart';
import 'package:menu/features/home/pages/home/tabs/menu/menu_tab.dart';
import 'package:menu/features/home/pages/home/widgets/home_bottom_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageController homePageController = HomePageController(
    changePage: changePage,
  );

  final PageController pageController = PageController();

  void changePage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homePageController,
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (page) {
                homePageController.onPageChanged(page);
              },
              children: const [
                HomeTab(),
                MenuTab(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<HomePageController>(builder: (_, __, ___) {
                return HomeBottomBar(
                  page: homePageController.page,
                  onChanged: changePage,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
