import 'package:get/get.dart';

import '../../shared/model/breed.dart';
import '../../shared/repositories/interfaces/i_dogs_repository.dart';
import '../../shared/utils/controller_state.dart';

class BreedsListController extends GetxController {
  static BreedsListController get to => Get.find();

  List<Breed> breeds = <Breed>[].obs;
  set _breeds(List<Breed> items) => breeds.assignAll(items);

  ControllerState state = ControllerState<GetBreedsError>.isLoading();

  @override
  void onInit() {
    super.onInit();
    fetchBreeds();
  }

  void fetchBreeds() async {
    state.setIsLoading();
    try {
      List<Breed> breeds = await IDogsRepository.to.getBreeds();
      this.breeds = breeds;

      state.setHasData();
    } catch (e) {
      if (e is GetBreedsError) return state.setHasError(e);
      state.setHasError(GetBreedsError.unexpected);
    }
  }

  void toBreedImages(Breed breed) {
    throw UnimplementedError();
  }
}
