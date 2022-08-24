import 'dart:developer';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/core/enums/order_status.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool isLoading = false;

  void setIsLoadMoreRunning(bool value) {
    isLoadMoreRunning = value;
    update();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  late final ScrollController scrollController;

  bool get _isExtentAfter => scrollController.position.extentAfter < 300;

  List<OrderModel> orders = [];

  int quantityOfOrder(OrderModel order) {
    return order.products
        .map((product) => product.quantity)
        .reduce((a, b) => a + b);
  }

  Future<void> loadData() async {
    setIsLoading(true);
    orders = await AppRepositories.ordersRepository.getAllOrders(limit: 6);
    setIsLoading(false);
    scrollController.jumpTo(scrollController.offset + Get.height * .2);
    scrollController.jumpTo(0);
  }

  Future<void> refreshData() async {
    orders = await AppRepositories.ordersRepository
        .getAllOrders(limit: orders.length);
    update();
  }

  void setOrder(OrderModel newOrder) {
    final refreshedOrderIndex = orders.indexWhere((e) => e.id == newOrder.id);

    orders[refreshedOrderIndex] = newOrder;

    update();
  }

  Future<void> loadMore() async {
    if (hasNextPage && !isLoading && !isLoadMoreRunning && _isExtentAfter) {
      setIsLoadMoreRunning(true);

      final fetchedOrders = await AppRepositories.ordersRepository.getAllOrders(
        startAfterOrderTimeOrdered: orders.last.timeOrdered,
        limit: 6,
      );

      if (fetchedOrders.isNotEmpty) {
        orders.addAll(fetchedOrders);
        log("Loaded Other ${fetchedOrders.length} Orders");
      } else {
        setHasNextPage(false);
      }
      setIsLoadMoreRunning(false);
    }
  }

  OrderStatus? ordersStatus;

  void setOrdersStatus(OrderStatus? status) {
    ordersStatus = status;
    update();
  }

  List<OrderModel> get filteredOrders {
    if (ordersStatus == null) return orders;
    return orders.where((order) => order.status == ordersStatus).toList();
  }

  @override
  void onInit() {
    loadData();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
    super.onInit();
  }
}
