import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  int _pagesCurrentIndex = 0;
  int get pagesCurrentIndex => _pagesCurrentIndex;

  final List<Widget> pages = [
    Container(),
    Container(),
    Container(),
  ];

  Widget get currentScreen {
    return IndexedStack(
      index: _pagesCurrentIndex,
      children: pages,
    );
  }

  void changepagesCurrentIndex(int index) {
    _pagesCurrentIndex = index;
    update();
  }
}
