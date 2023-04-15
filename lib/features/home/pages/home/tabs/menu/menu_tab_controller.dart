import 'package:get/get.dart';

import 'package:menu/core/extensions/string_extension.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/home/repositories/home_repository.dart';

class MenuTabController extends GetxController {
  final HomeRepository _homeRepository = Get.find();
  final Rxn<List<HomeSection>> _sections = Rxn<List<HomeSection>>();

  Future<void> loadSections() async {
    _sections.value = await _homeRepository.getMenuSections();
  }

  final RxString search = ''.obs;

  void setSearch(String s) {
    search.value = s;
  }

  List<HomeSection>? get sections {
    if (_sections.value == null) {
      return null;
    } else if (search.isEmpty) {
      return _sections.value;
    } else {
      return List<HomeSection>.from(
        _sections.value!
            .map<HomeSection?>((s) => s.copyFiltered(search.value.clear))
            .where((s) => s != null)
            .toList(),
      );
    }
  }
}
