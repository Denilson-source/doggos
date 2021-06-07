import 'package:flutter/Material.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const home = '/';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => SizedBox(),
    ),
  ];
}
