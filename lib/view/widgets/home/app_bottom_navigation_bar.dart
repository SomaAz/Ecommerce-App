import 'package:ecommerce_getx/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: controller.navBarCurrentIndex,
          onTap: controller.navigateToIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          // selectedIconTheme:
          //     Get.theme.iconTheme.copyWith(color: Get.theme.primaryColor),
          // unselectedIconTheme:
          //     Get.theme.iconTheme.copyWith(color: Colors.black),
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "Explore",
              activeIcon: Icon(Icons.explore),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart_rounded),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: "Account",
            ),
          ],
        );
      },
    );
  }
}
