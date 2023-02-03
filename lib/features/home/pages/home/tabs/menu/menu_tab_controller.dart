import 'package:flutter/cupertino.dart';
import 'package:menu/core/extensions/string_extension.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/home/repositories/home_repository.dart';

class MenuTabController extends ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepository();

  List<HomeSection>? _sections;

  Future<void> loadSections() async {
    _sections = await _homeRepository.getMenuSections();
    notifyListeners();
  }

  String search = '';

  void setSearch(String s) {
    search = s;
    notifyListeners();
  }

  List<HomeSection>? get sections {
    if (_sections == null) {
      return null;
    } else if (search.isEmpty) {
      return _sections;
    } else {
      return List<HomeSection>.from(
        _sections!
            .map<HomeSection?>((s) => s.copyFiltered(search.clear))
            .where((s) => s != null)
            .toList(),
      );
    }
  }
}
