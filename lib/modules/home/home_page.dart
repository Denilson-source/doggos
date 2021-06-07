import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTab(),
      bottomNavigationBar: _builtBottomNavigationBar(),
    );
  }

  Widget _buildTab() {
    return Obx(() {
      switch (controller.currentTab) {
        case HomeTab.home:
          return SizedBox();
        case HomeTab.favorites:
          return SizedBox();
      }
    });
  }

  Widget _builtBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        onTap: (value) => controller.currentTab = HomeTab.values[value],
        currentIndex: controller.currentTab.index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      );
    });
  }
}
