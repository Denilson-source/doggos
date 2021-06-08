import 'package:get/get.dart';

import 'favorite_breeds_controller.dart';

class FavoriteBreedsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteBreedsController());
  }
}
