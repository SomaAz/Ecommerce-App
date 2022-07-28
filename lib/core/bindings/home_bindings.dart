import 'package:ecommerce_getx/controller/home/explore_controller.dart';
import 'package:ecommerce_getx/controller/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ExploreController());
  }
}
