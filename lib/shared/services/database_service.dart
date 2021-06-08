import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService get to => Get.find();

  Database? _db;

  Future<void> createDatabase(Database db) {
    return db.execute('''
    create table breeds ( 
      name text primary key, 
      variants text
    )
    ''');
  }

  Future<Database> open() async {
    if (_db == null)
      _db = await openDatabase(
        'dogsApp',
        version: 1,
        onCreate: (db, version) => createDatabase(db),
      );

    return _db!;
  }
}
