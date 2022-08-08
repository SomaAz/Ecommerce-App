import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:get/get.dart';

class TrackOrderController extends GetxController {
  late OrderModel order;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  void setIsRefreshing(bool value) {
    _isRefreshing = value;
    update();
  }

  Future<void> refreshData() async {
    setIsRefreshing(true);
    final ordersController = Get.find<OrdersController>();
    await ordersController.refreshData();
    order = ordersController.orders
        .firstWhere((e) => e.id == order.id, orElse: () => order);
    setIsRefreshing(false);
  }

  @override
  void onInit() {
    order = Get.arguments;
    super.onInit();
  }
}
