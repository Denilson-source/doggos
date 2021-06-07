import 'package:get/get.dart';

import 'breeds_list_controller.dart';

class BreedsListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreedsListController());
  }
}
