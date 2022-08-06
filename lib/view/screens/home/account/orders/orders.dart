import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/outlined_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<OrdersController>().refreshData();
        },
        child: CustomSliverLayout(
          title: "Orders",
          children: [
            GetBuilder<OrdersController>(
              builder: (controller) {
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const GapH(20),
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return OrderCard(
                      order,
                      quantity: controller.quantityOfOrder(order),
                    );
                  },
                  itemCount: controller.orders.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard(
    this.order, {
    required this.quantity,
    Key? key,
  }) : super(key: key);

  final OrderModel order;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order No.${order.number}",
                  style: Get.textTheme.headline4,
                ),
                Text(
                  DateFormat("dd-MM-yyyy").format(
                    order.timeOrdered.toDate(),
                  ),
                  style: Get.textTheme.bodyText1!.copyWith(height: 0),
                ),
              ],
            ),
            const GapH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Quantity:  ",
                        style: Get.textTheme.bodyText1!.copyWith(height: 0),
                      ),
                      TextSpan(
                        text: "$quantity",
                        style: Get.textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Total Price:  ",
                        style: Get.textTheme.bodyText1!.copyWith(height: 0),
                      ),
                      TextSpan(
                        text: "\$${order.price}",
                        style: Get.textTheme.headline4!.copyWith(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const GapH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    order.status.name,
                    style: Get.textTheme.headline5!.copyWith(
                      color: order.status.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                OutlinedCustomButton(
                  text: "Details",
                  onPressed: () {
                    Get.toNamed(AppRoutes.orderDetails, arguments: order);
                  },
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
