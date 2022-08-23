import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/enums/order_status.dart';
import 'package:ecommerce_getx/view/widgets/centered_text.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/order_card.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/order_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: CustomSliverLayout(
          controller: controller.scrollController,
          title: "Orders",
          actions: [
            GetBuilder<OrdersController>(
              builder: (controller) {
                return DropdownButton<OrderStatus>(
                  value: controller.ordersStatus,
                  items: [
                    const DropdownMenuItem(value: null, child: Text("All")),
                    DropdownMenuItem(
                      value: OrderStatus.processing,
                      child: Text(
                        OrderStatus.processing.name,
                        style: TextStyle(color: OrderStatus.processing.color),
                      ),
                    ),
                    DropdownMenuItem(
                      value: OrderStatus.delivered,
                      child: Text(
                        OrderStatus.delivered.name,
                        style: TextStyle(color: OrderStatus.delivered.color),
                      ),
                    ),
                    DropdownMenuItem(
                      value: OrderStatus.canceled,
                      child: Text(
                        OrderStatus.canceled.name,
                        style: TextStyle(color: OrderStatus.canceled.color),
                      ),
                    ),
                  ],
                  onChanged: controller.setOrdersStatus,
                  underline: const Gap(),
                );
              },
            ),
          ],
          children: [
            GetBuilder<OrdersController>(
              builder: (controller) {
                if (!controller.isLoading) {
                  if (controller.orders.isEmpty) {
                    return SizedBox(
                      height: remainingScreenHeight,
                      child:
                          const CustomCenteredText("You Don't Have Any Orders"),
                    );
                  }
                  if (controller.filteredOrders.isEmpty) {
                    return SizedBox(
                      height: remainingScreenHeight,
                      child: CustomCenteredText(
                          "You Don't Have Any ${controller.ordersStatus?.name} Orders"),
                    );
                  }
                }
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const GapH(20),
                  itemBuilder: (context, index) {
                    if (controller.isLoading) {
                      return const OrderCardShimmer();
                    }

                    final order = controller.filteredOrders[index];
                    return OrderCard(
                      order,
                      quantity: controller.quantityOfOrder(order),
                    );
                  },
                  itemCount: controller.isLoading
                      ? (Get.height ~/ (Get.height * .2))
                      : controller.filteredOrders.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
