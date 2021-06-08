import 'package:sqflite/sqflite.dart';

import '../../model/breed.dart';
import '../../services/database_service.dart';
import '../../utils/types.dart';
import '../interfaces/i_favorites_repository.dart';

class LocalFavoritesRepository implements IFavoritesRepository {
  @override
  Future<void> addFavorite(Breed breed) async {
    try {
      Database db = await DatabaseService.to.open();
      await db.insert('breeds', breed.toJson());
    } catch (e) {
      print(e);
      if (e is AddFavoriteError) rethrow;
      throw AddFavoriteError.unexpected;
    }
  }

  @override
  Future<List<Breed>> getFavorites() async {
    try {
      Database db = await DatabaseService.to.open();
      List<Json> data = await db.query('breeds');

      return data.map((e) => Breed.fromJson(e)).toList();
    } catch (e) {
      print(e);
      if (e is GetFavoritesError) rethrow;
      throw GetFavoritesError.unexpected;
    }
  }

  @override
  Future<bool> isFavorite(String breedName) async {
    try {
      Database db = await DatabaseService.to.open();
      List<Json> data = await db.query(
        'breeds',
        where: 'name = ?',
        whereArgs: [breedName],
      );

      return data.isNotEmpty;
    } catch (e) {
      print(e);
      if (e is IsFavoriteError) rethrow;
      throw IsFavoriteError.unexpected;
    }
  }

  @override
  Future<void> removeFavorite(String breedName) async {
    try {
      Database db = await DatabaseService.to.open();
      await db.delete('breeds', where: 'name = ?', whereArgs: [breedName]);
    } catch (e) {
      print(e);
      if (e is RemoveFavoriteError) rethrow;
      throw RemoveFavoriteError.unexpected;
    }
  }
}
