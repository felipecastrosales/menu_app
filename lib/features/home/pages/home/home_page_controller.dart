import 'package:flutter/cupertino.dart';

enum HomePageTab { home, menu }

class HomePageController extends ChangeNotifier {
  HomePageController({required this.changePage});

  final Function(int) changePage;

  int page = 0;

  void onPageChanged(int newPage) {
    page = newPage;
    notifyListeners();
  }
}
