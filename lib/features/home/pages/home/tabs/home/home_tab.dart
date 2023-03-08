import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:menu/core/widgets/core_page_title.dart';
import 'package:menu/features/home/models/home_banner_section.dart';
import 'package:menu/features/home/models/home_menu_button_section.dart';
import 'package:menu/features/home/models/home_products_carousel_section.dart';
import 'package:menu/features/home/pages/home/tabs/home/home_tab_controller.dart';
import 'package:menu/features/home/widgets/home_banner_section_widget.dart';
import 'package:menu/features/home/widgets/home_menu_button_section_widget.dart';
import 'package:menu/features/home/widgets/home_products_carousel_section_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeTabController controller = HomeTabController();

  @override
  void initState() {
    super.initState();

    controller.loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 24 + 60 + 16,
      ),
      children: [
        const CorePageTitle(
          title: 'Felipo\'s Mexican Food',
        ),
        Obx(() {
          if (controller.sections.value == null) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 50,
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 24),
            itemBuilder: (_, i) {
              final section = controller.sections.value![i];
              if (section is HomeProductsCarouselSection) {
                return HomeProductsCarouselSectionWidget(section: section);
              } else if (section is HomeBannerSection) {
                return HomeBannerSectionWidget(section: section);
              } else if (section is HomeMenuButtonSection) {
                return HomeMenuButtonSectionWidget(section: section);
              } else {
                return Container();
              }
            },
            separatorBuilder: (_, __) => const SizedBox(height: 24),
            itemCount: controller.sections.value!.length,
          );
        }),
      ],
    );
  }
}
