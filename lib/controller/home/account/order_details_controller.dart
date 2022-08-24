import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/core/enums/order_status.dart';
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

  Future<void> changeOrderStatus(OrderStatus newStatus) async {
    await AppRepositories.ordersRepository
        .changeOrderStatus(order, newStatus)
        .then(
      (value) {
        Get.find<OrdersController>()
            .setOrder(_order.copyWith(status: newStatus));
        _order = _order.copyWith(status: newStatus);
        update();
      },
    );
  }

  @override
  void onInit() {
    setOrder(Get.arguments);
    super.onInit();
  }
}
