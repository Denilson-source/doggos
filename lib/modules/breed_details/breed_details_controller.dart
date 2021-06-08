import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/model/breed.dart';
import '../../shared/repositories/interfaces/i_dogs_repository.dart';
import '../../shared/utils/controller_state.dart';

class BreedDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  static BreedDetailsController get to => Get.find();

  TabController? imagesSliderController;

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
  }

  void init() {
    List<String> images = breed.images ?? [];

    if (images.isEmpty) {
      return fetchImages();
    }

    state.setHasData();
    this.imagesSliderController = TabController(
      length: images.length,
      vsync: this,
    );
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
}
