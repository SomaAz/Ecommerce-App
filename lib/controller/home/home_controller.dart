import 'package:ecommerce_getx/view/screens/home/explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int _navBarCurrentIndex = 0;
  int get navBarCurrentIndex => _navBarCurrentIndex;

  static const _screens = [
    ExploreScreen(),
    // ExploreScreen(),
    // ExploreScreen(),
  ];

  Widget get currentScreen {
    return IndexedStack(
      index: _navBarCurrentIndex,
      children: _screens,
    );
  }

  void changeNavBarCurrentIndex(int index) {
    _navBarCurrentIndex = index;
    update();
  }
}
