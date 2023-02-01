import 'package:flutter/material.dart';
import 'package:menu/features/home/pages/tabs/home/widgets/home_tab.dart';

import '../widgets/home_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                this.page = page;
              });
            },
            children: [
              const HomeTab(),
              Container(
                color: Colors.green,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HomeBottomBar(
              page: page,
              onChanged: (page) {
                pageController.animateToPage(
                  page,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 300),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
