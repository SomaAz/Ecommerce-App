import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  late OrderModel _order;
  OrderModel get order => _order;

  void setOrder(OrderModel value) {
    _order = value;
    update();
  }

  int get quantity {
    return order.products
        .map((product) => product.quantity)
        .reduce((a, b) => a + b);
  }

  @override
  void onInit() {
    setOrder(Get.arguments);
    super.onInit();
  }
}
