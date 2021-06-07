import 'package:get/get.dart';

import 'modules/home/home_bindings.dart';
import 'modules/home/home_page.dart';

abstract class Routes {
  static const home = '/';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
  ];
}
