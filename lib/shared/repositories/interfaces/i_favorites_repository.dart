import 'package:doggos/shared/model/breed.dart';
import 'package:get/get.dart';

abstract class IFavoritesRepository {
  static IFavoritesRepository get to => Get.find();

  Future<List<Breed>> getFavorites();
  Future<void> addFavorite(Breed breed);
  Future<void> removeFavorite(String breedName);
  Future<bool> isFavorite(String breedName);
}

enum GetFavoritesError { unexpected }
enum AddFavoriteError { unexpected }
enum RemoveFavoriteError { unexpected }
enum IsFavoriteError { unexpected }
