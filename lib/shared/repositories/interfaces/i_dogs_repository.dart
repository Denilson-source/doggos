import 'package:doggos/shared/model/breed.dart';
import 'package:get/get.dart';

abstract class IDogsRepository {
  static IDogsRepository get to => Get.find();

  Future<List<Breed>> getBreeds();
  Future<List<String>> getBreedImages(String breed);
}

enum GetBreedsError { unexpected }
enum GetBreedImagesError { unexpected }
