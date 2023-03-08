import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu/features/home/pages/home/tabs/menu/menu_tab_controller.dart';

class MenuTabSearchField extends StatefulWidget {
  const MenuTabSearchField({super.key});

  @override
  State<MenuTabSearchField> createState() => _MenuTabSearchFieldState();
}

class _MenuTabSearchFieldState extends State<MenuTabSearchField> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MenuTabController controller = Get.find<MenuTabController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextFormField(
        key: const Key('search-field'),
        controller: searchController,
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: 'Pesquisar',
          hintStyle: const TextStyle(color: Colors.white54),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          border: InputBorder.none,
          suffixIcon: controller.search.value.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.setSearch('');
                    searchController.clear();
                  },
                  icon: const Icon(Icons.close),
                  color: const Color(0xff5f6066),
                )
              : null,
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: controller.setSearch,
      ),
    );
  }
}
