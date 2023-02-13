import 'package:flutter/material.dart';
import 'package:menu/features/cart/controllers/cart_controller.dart';
import 'package:menu/features/home/pages/home/home_page_controller.dart';
import 'package:menu/features/home/pages/home/tabs/home/home_tab.dart';
import 'package:menu/features/home/pages/home/tabs/menu/menu_tab.dart';
import 'package:menu/features/home/pages/home/widgets/home_bottom_bar.dart';
import 'package:menu/features/home/pages/home/widgets/home_cart_button.dart';
import 'package:menu/features/home/pages/home/widgets/home_cart_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.table}) : super(key: key);

  final String? table;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageController homePageController = HomePageController(
    changePage: changePage,
  );

  final PageController pageController = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool drawerOpen = false;

  void changePage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<CartController>().setTable(widget.table);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homePageController,
      child: Stack(
        children: [
          Scaffold(
            key: scaffoldKey,
            endDrawer: const HomeCartDrawer(),
            onEndDrawerChanged: (open) {
              setState(() {
                drawerOpen = open;
              });
            },
            body: Stack(
              children: [
                Builder(
                  builder: (context) {
                    return PageView(
                      controller: pageController,
                      onPageChanged: homePageController.onPageChanged,
                      children: const [
                        HomeTab(),
                        MenuTab(),
                      ],
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<HomePageController>(
                    builder: (_, __, ___) {
                      return HomeBottomBar(
                        page: homePageController.page,
                        onChanged: changePage,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 24 + MediaQuery.of(context).viewPadding.top,
            child: HomeCartButton(
              scaffoldKey: scaffoldKey,
              drawerOpen: drawerOpen,
            ),
          ),
        ],
      ),
    );
  }
}
