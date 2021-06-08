import 'package:get/get.dart';

import 'modules/breed_details/breed_details_bindings.dart';
import 'modules/breed_details/breed_details_page.dart';
import 'modules/breeds_list/breeds_list_bindings.dart';
import 'modules/favorites_breeds/favorite_breeds_bindings.dart';
import 'modules/home/home_bindings.dart';
import 'modules/home/home_page.dart';

abstract class Routes {
  static const home = '/';

  /// expect a [Breed] as argument
  static const breedDetails = '/breedDetails';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      bindings: [
        HomeBindings(),
        BreedsListBindings(),
        FavoriteBreedsBindings(),
      ],
    ),
    GetPage(
      name: breedDetails,
      page: () => BreedDetailsPage(),
      binding: BreedDetailsBindings(),
    ),
  ];
}
