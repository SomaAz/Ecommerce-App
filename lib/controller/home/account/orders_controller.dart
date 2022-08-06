import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  int quantityOfOrder(OrderModel order) {
    return order.products
        .map((product) => product.quantity)
        .reduce((a, b) => a + b);
  }

  List<OrderModel> orders = [];

  Future<void> loadData() async {
    setIsLoading(true);
    orders = await ordersRepository.getAllOrders();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    orders = await ordersRepository.getAllOrders();
    update();
  }

  @override
  void onInit() async {
    await loadData();
    super.onInit();
  }
}
