import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:menu/features/home/models/home_menu_button_section.dart';
import 'package:menu/features/home/pages/home/home_page_controller.dart';

class HomeMenuButtonSectionWidget extends StatelessWidget {
  const HomeMenuButtonSectionWidget({
    super.key,
    required this.section,
  });

  final HomeMenuButtonSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            final HomePageController controller = context.read();
            controller.changePage(HomePageTab.menu.index);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Ver menu completo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
