import 'package:ecommerce_getx/controller/home/explore/best_selling_controller.dart';
import 'package:ecommerce_getx/controller/home/explore/explore_controller.dart';
import 'package:get/get.dart';

class ExploreBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ExploreController());
    Get.put(BestSellingController());
  }
}
