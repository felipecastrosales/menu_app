import 'package:get/get.dart';

enum HomePageTab { home, menu }

class HomePageController extends GetxController {
  HomePageController({required this.changePage});

  final Function(int) changePage;

  final RxInt page = 0.obs;

  void onPageChanged(int newPage) {
    page.value = newPage;
  }
}
