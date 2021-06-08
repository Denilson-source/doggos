import 'package:get/get.dart';

import '../../routes.dart';
import '../../shared/model/breed.dart';
import '../../shared/repositories/interfaces/i_favorites_repository.dart';
import '../../shared/utils/controller_state.dart';

class FavoriteBreedsController extends GetxController {
  static FavoriteBreedsController get to => Get.find();

  RxList<Breed> _breeds = RxList<Breed>();
  List<Breed> get breeds => _breeds;
  set breeds(List<Breed> items) => _breeds.assignAll(items);

  ControllerState state = ControllerState<GetFavoritesError>.isLoading();

  @override
  void onInit() {
    super.onInit();
    fetchBreeds();
  }

  void fetchBreeds() async {
    state.setIsLoading();
    try {
      List<Breed> breeds = await IFavoritesRepository.to.getFavorites();
      this.breeds = breeds;

      state.setHasData();
    } catch (e) {
      if (e is GetFavoritesError) return state.setHasError(e);
      state.setHasError(GetFavoritesError.unexpected);
    }
  }

  void toBreedImages(Breed breed) async {
    await Get.toNamed(Routes.breedDetails, arguments: breed);
    if (!breed.isFavorite!) {
      _breeds.remove(breed);
    }
  }
}
