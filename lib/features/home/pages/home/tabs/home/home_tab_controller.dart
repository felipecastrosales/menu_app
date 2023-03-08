import 'package:get/get.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/home/repositories/home_repository.dart';

class HomeTabController extends GetxController {
  final HomeRepository homeRepository = Get.find();

  final Rxn<List<HomeSection>> sections = Rxn<List<HomeSection>>();

  Future<void> loadSections() async {
    sections.value = await homeRepository.getHomeSections();
  }
}
