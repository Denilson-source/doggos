import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';
import 'shared/repositories/implementations/dogs_repository.dart';
import 'shared/repositories/implementations/local_favorites_repository.dart';
import 'shared/repositories/interfaces/i_dogs_repository.dart';
import 'shared/repositories/interfaces/i_favorites_repository.dart';
import 'shared/services/database_service.dart';
import 'shared/services/http_service.dart';
import 'shared/utils/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doggos',
      theme: ThemeData(
        primarySwatch: hexToMaterialColor('#161b22'),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: Routes.home,
      getPages: Routes.pages,
      initialBinding: BindingsBuilder(initialBindings),
    );
  }
}

void initialBindings() {
  Get.put(HttpService(), permanent: true);
  Get.put(DatabaseService(), permanent: true);

  Get.put<IDogsRepository>(DogsRepository(), permanent: true);
  Get.put<IFavoritesRepository>(LocalFavoritesRepository(), permanent: true);

  // Get.put<IDogsRepository>(DogsRepositoryMock(), permanent: true);
  // Get.put<IFavoritesRepository>(FavoritesRepositoryMock(), permanent: true);
}
