import 'package:faker/faker.dart';

import '../../model/breed.dart';
import '../../utils/utils.dart';
import '../interfaces/i_dogs_repository.dart';

class DogsRepositoryMock implements IDogsRepository {
  @override
  Future<List<String>> getBreedImages(String breed) async {
    await delay();
    return List.generate(
      10,
      (index) => 'https://images.dog.ceo/breeds/redbone/n02090379_1006.jpg',
    );
  }

  @override
  Future<List<Breed>> getBreeds() async {
    await delay();
    return List.generate(
      50,
      (index) => Breed(
        name: faker.lorem.word(),
        variants: random.boolean()
            ? List.generate(5, (index) => faker.lorem.word())
            : null,
      ),
    );
  }
}
