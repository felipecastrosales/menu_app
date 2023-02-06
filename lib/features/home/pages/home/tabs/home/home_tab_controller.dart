import 'package:flutter/cupertino.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/home/repositories/home_repository.dart';

class HomeTabController extends ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();

  List<HomeSection>? sections;

  Future<void> loadSections() async {
    sections = await homeRepository.getHomeSections();
    notifyListeners();
  }
}