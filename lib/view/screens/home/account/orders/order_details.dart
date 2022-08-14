import 'package:ecommerce_getx/controller/home/account/order_details_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_credit_card.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/order_product_card.dart';
import 'package:ecommerce_getx/view/widgets/shipping_address_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderDetailsController>(
        builder: (controller) {
          final order = controller.order;
          return CustomSliverLayout(
            title: "Order Details",
            children: [
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  Text(
                    order.status.name,
                    style: Get.textTheme.headline5!
                        .copyWith(color: order.status.color),
                  ),
                  const GapH(40),
                  Text(
                    "${order.products.length} items",
                    style: Get.textTheme.headline4,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const GapH(15),
                    itemBuilder: ((context, index) {
                      return OrderProductCard(order.products[index]);
                    }),
                    itemCount: order.products.length,
                  ),
                  const GapH(40),
                  Text(
                    "Order Information",
                    style: Get.textTheme.headline4,
                  ),
                  const GapH(25),
                  Text(
                    "Shipping Address:",
                    style: Get.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const GapH(10),
                  SizedBox(
                    width: double.infinity,
                    child: ShippingAddressCard(order.shippingAddress),
                  ),
                  const GapH(25),
                  Text(
                    "Payment Card:",
                    style: Get.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const GapH(10),
                  CustomCreditCard(
                    order.paymentCard.copyWith(
                      number: order.paymentCard.number.replaceRange(
                        0,
                        order.paymentCard.number.length - 4,
                        "*" * (order.paymentCard.number.length - 7),
                      ),
                    ),
                  ),
                  const GapH(25),
                  Row(
                    children: [
                      Text(
                        "Delivery Method:  ",
                        style: Get.textTheme.bodyText1!.copyWith(height: 0),
                      ),
                      Text(
                        "${order.deliveryType == DeliveryType.standard ? "Standard" : "Next Day"} Delivery",
                        style: Get.textTheme.headline5!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const GapH(20),
                  Row(
                    children: [
                      Text(
                        "Total Price:  ",
                        style: Get.textTheme.bodyText1!.copyWith(height: 0),
                      ),
                      Text(
                        "\$${order.price}",
                        style: Get.textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<OrderDetailsController>(
        builder: (controller) {
          return Container(
            height: Get.statusBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: CustomButton(
              text: "Track Order",
              onPressed: () {
                Get.toNamed(AppRoutes.trackOrder, arguments: controller.order);
              },
            ),
          );
        },
      ),
    );
  }
}
