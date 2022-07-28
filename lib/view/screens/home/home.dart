import 'package:ecommerce_getx/controller/home/home_controller.dart';
import 'package:ecommerce_getx/view/widgets/home/app_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return controller.currentScreen;
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
