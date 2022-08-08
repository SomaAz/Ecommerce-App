import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:get/get.dart';

class TrackOrderController extends GetxController {
  late final OrderModel order;

  @override
  void onInit() {
    order = Get.arguments;
    super.onInit();
  }
}
