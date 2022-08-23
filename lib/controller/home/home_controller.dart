import 'package:ecommerce_getx/core/enums/notification_type.dart';
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

  void navigateToIndex(int index) {
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
      print(notification);
      print(message.data);
      if (message.data['messageType'] == "order_status_changed") {
        print(NotificationType.orderStatusChanged);
        print("Data:${message.data}");
        print("Title:${notification?.title}");
        print("Body:${notification?.body}");
        Get.dialog(AlertDialog(
          title: Text(message.notification?.title ?? "No Title"),
          content: Column(
            children: [
              Text("Data:${message.data}"),
              Text("Body:${notification?.body}"),
              Text("Type:${message.data['messageType']}"),
            ],
          ),
        ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final notification = message.notification;
      print("${notification?.title}");
    });
  }

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    // _handleFirebaseMessaging();
    super.onInit();
  }
}
