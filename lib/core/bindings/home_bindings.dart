import 'package:ecommerce_getx/controller/home/account/account_controller.dart';
import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/controller/home/explore/explore_controller.dart';
import 'package:ecommerce_getx/controller/home/favorites_controller.dart';
import 'package:ecommerce_getx/controller/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => ExploreController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => FavoritesController());
    Get.lazyPut(() => AccountController());
  }
}
