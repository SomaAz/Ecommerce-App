import 'package:ecommerce_getx/view/screens/home/account/account.dart';
import 'package:ecommerce_getx/view/screens/home/cart/cart.dart';
import 'package:ecommerce_getx/view/screens/home/explore/explore.dart';
import 'package:ecommerce_getx/view/screens/home/favorites.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int _navBarCurrentIndex = 0;
  int get navBarCurrentIndex => _navBarCurrentIndex;

  static const screens = [
    ExploreScreen(),
    CartScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  late final TabController tabController;

  Widget get currentScreen {
    return IndexedStack(
      index: _navBarCurrentIndex,
      children: screens,
    );
  }

  void changeNavBarCurrentIndex(int index) {
    _navBarCurrentIndex = index;
    tabController.animateTo(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
    update();
  }

  //? Firebase Messaging

  void _handleFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      print("${notification?.title}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final notification = message.notification;
      print("${notification?.title}");
    });
  }

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    _handleFirebaseMessaging();
    super.onInit();
  }
}
