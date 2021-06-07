import 'package:doggos/modules/breeds_list/breeds_list_bindings.dart';
import 'package:get/get.dart';

import 'modules/home/home_bindings.dart';
import 'modules/home/home_page.dart';

abstract class Routes {
  static const home = '/';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      bindings: [
        HomeBindings(),
        BreedsListBindings(),
      ],
    ),
  ];
}
