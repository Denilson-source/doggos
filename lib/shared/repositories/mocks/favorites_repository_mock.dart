import 'package:doggos/shared/model/breed.dart';
import 'package:doggos/shared/repositories/interfaces/i_favorites_repository.dart';
import 'package:doggos/shared/utils/utils.dart';
import 'package:faker/faker.dart';

class FavoritesRepositoryMock implements IFavoritesRepository {
  @override
  Future<void> addFavorite(Breed breed) async {
    await delay();
  }

  @override
  Future<List<Breed>> getFavorites() async {
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

  @override
  Future<bool> isFavorite(String breedName) async {
    await delay();
    return random.boolean();
  }

  @override
  Future<void> removeFavorite(String breedName) async {
    await delay();
  }
}
