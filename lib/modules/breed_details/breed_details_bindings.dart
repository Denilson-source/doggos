import 'package:get/get.dart';

import 'breed_details_controller.dart';

class BreedDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreedDetailsController());
  }
}
