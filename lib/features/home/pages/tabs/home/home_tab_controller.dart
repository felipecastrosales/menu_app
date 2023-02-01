import 'package:flutter/material.dart';
import 'package:menu/features/home/models/home_section.dart';
import 'package:menu/features/home/repositories/home_repository.dart';

class HomeTabController extends ChangeNotifier {
  final homeRepository = HomeRepository();

  List<HomeSection>? sections;

  Future<void> loadSections() async {
    sections = await homeRepository.getHomeSections();
    notifyListeners();
  }
}
