import 'package:ecommerce_getx/controller/home/account/order_details_controller.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:get/get.dart';

import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';

class TrackOrderController extends GetxController {
  TrackOrderController() : order = Get.arguments;

  OrderModel order;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  void setIsRefreshing(bool value) {
    _isRefreshing = value;
    update();
  }

  Future<void> refreshData() async {
    setIsRefreshing(true);

    final refreshedOrder =
        await AppRepositories.ordersRepository.getOrderOfId(order.id);
    order = refreshedOrder;

    final orderDetailsController = Get.find<OrderDetailsController>();
    orderDetailsController.setOrder(order);

    final ordersController = Get.find<OrdersController>();
    ordersController.setOrder(order);

    setIsRefreshing(false);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
