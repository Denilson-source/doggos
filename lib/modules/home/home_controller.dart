import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final _rxCurrentTab = Rx<HomeTab>(HomeTab.home);
  HomeTab get currentTab => _rxCurrentTab.value;
  set currentTab(HomeTab value) => _rxCurrentTab.value = value;
}

enum HomeTab { home, favorites }
