import 'package:doggos/shared/repositories/interfaces/i_favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/model/breed.dart';
import '../../shared/repositories/interfaces/i_dogs_repository.dart';
import '../../shared/utils/controller_state.dart';
import 'widgets/image_carrousel.dart';

class BreedDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  static BreedDetailsController get to => Get.find();

  final _rxBreed = Rx<Breed>(Get.arguments);
  Breed get breed => _rxBreed.value;
  set breed(Breed value) => _rxBreed.value = value;

  ControllerState state = ControllerState<GetBreedImagesError>.isLoading();

  @override
  void onInit() {
    super.onInit();

    if (breed.images?.isEmpty ?? true) {
      fetchImages();
    } else {
      state.setHasData();
    }

    if (breed.isFavorite == null) {
      checkFavorite();
    }
  }

  void fetchImages() async {
    state.setIsLoading();
    try {
      List<String> images = await IDogsRepository.to.getBreedImages(breed.name);
      breed.images = images;
      _rxBreed.refresh();

      state.setHasData();
    } catch (e) {
      if (e is GetBreedImagesError) return state.setHasError(e);
      state.setHasError(GetBreedImagesError.unexpected);
    }
  }

  void showImageCarrousel(int index) {
    Get.dialog(ImageCarrousel(
      images: breed.images!,
      initialIndex: index,
    ));
  }

  void checkFavorite() async {
    try {
      breed.isFavorite = await IFavoritesRepository.to.isFavorite(breed.name);
      _rxBreed.refresh();
    } catch (e) {
      breed.isFavorite = false;
      _rxBreed.refresh();
    }
  }

  void toggleFavorite() async {
    bool isFavorite = breed.isFavorite!;
    breed.isFavorite = !isFavorite;
    _rxBreed.refresh();

    try {
      if (isFavorite) {
        await IFavoritesRepository.to.removeFavorite(breed.name);
      } else {
        await IFavoritesRepository.to.addFavorite(breed);
      }
    } catch (e) {
      breed.isFavorite = isFavorite;
      _rxBreed.refresh();

      Get.snackbar("Error", 'Error while trying favorite/unfavorite');
    }
  }
}
