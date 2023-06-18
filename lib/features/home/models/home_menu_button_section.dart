import 'package:menu/features/home/models/home_section.dart';

class HomeMenuButtonSection extends HomeSection {
  static HomeMenuButtonSection fromJson(Map<String, dynamic> json) {
    return HomeMenuButtonSection();
  }

  @override
  HomeSection? copyFiltered(String search) {
    return null;
  }
}
