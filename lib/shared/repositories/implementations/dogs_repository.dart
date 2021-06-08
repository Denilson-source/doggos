import '../../model/breed.dart';
import '../../services/http_service.dart';
import '../interfaces/i_dogs_repository.dart';

class DogsRepository implements IDogsRepository {
  @override
  Future<List<String>> getBreedImages(String breed) async {
    try {
      String url = '/breed/$breed/images';
      HttpResponse res = await HttpService.to.get(path: url);

      if (res.status != 200) {
        throw GetBreedImagesError.unexpected;
      }

      List<String> images = [];
      res.data['message'].forEach((e) => images.add(e));
      return images;
    } catch (e) {
      print(e);
      if (e is GetBreedImagesError) rethrow;
      throw GetBreedImagesError.unexpected;
    }
  }

  @override
  Future<List<Breed>> getBreeds() async {
    try {
      String url = '/breeds/list/all';
      HttpResponse res = await HttpService.to.get(path: url);

      if (res.status != 200) {
        throw GetBreedsError.unexpected;
      }

      Map<String, dynamic> breedsRaw = res.data['message'];
      List<Breed> breeds = [];

      breedsRaw.forEach((key, value) {
        List<String> variants = [];
        value.forEach((e) => variants.add(e));

        breeds.add(Breed(name: key, variants: variants));
      });

      return breeds;
    } catch (e) {
      print(e);
      if (e is GetBreedsError) rethrow;
      throw GetBreedsError.unexpected;
    }
  }
}
