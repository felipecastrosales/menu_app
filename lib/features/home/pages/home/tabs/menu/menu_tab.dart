import 'package:flutter/material.dart';
import 'package:menu/core/widgets/core_page_title.dart';
import 'package:menu/features/home/models/home_banner_section.dart';
import 'package:menu/features/home/models/home_products_carousel_section.dart';
import 'package:menu/features/home/models/home_products_listing_section.dart';
import 'package:menu/features/home/pages/home/tabs/menu/menu_tab_controller.dart';
import 'package:menu/features/home/pages/home/tabs/menu/widgets/menu_tab_search_field.dart';
import 'package:menu/features/home/widgets/home_banner_section_widget.dart';
import 'package:menu/features/home/widgets/home_products_carousel_section_widget.dart';
import 'package:menu/features/home/widgets/home_products_listing_section_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  final MenuTabController controller = MenuTabController();

  @override
  void initState() {
    super.initState();
    controller.loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: ListView(
        padding: const EdgeInsets.only(
          top: 24,
          bottom: 24 + 60 + 16,
        ),
        children: [
          const CorePageTitle(
            title: 'Cardápio',
          ),
          const SizedBox(height: 24),
          Consumer<MenuTabController>(
            builder: (_, __, ___) {
              if (controller.sections == null) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: 50,
                  ),
                );
              }

              return Column(
                children: [
                  const MenuTabSearchField(),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 24),
                    itemBuilder: (_, index) {
                      final section = controller.sections![index];
                      if (section is HomeProductsListingSection) {
                        return HomeProductsListingSectionWidget(
                            section: section);
                      } else if (section is HomeBannerSection) {
                        return HomeBannerSectionWidget(section: section);
                      } else if (section is HomeProductsCarouselSection) {
                        return HomeProductsCarouselSectionWidget(
                            section: section);
                      } else {
                        return const SizedBox();
                      }
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemCount: controller.sections!.length,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
