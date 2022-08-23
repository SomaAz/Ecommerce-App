import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/controller/home/home_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/constant/theme.dart';
import 'package:ecommerce_getx/view/widgets/cart_product_card.dart';
import 'package:ecommerce_getx/view/widgets/centered_text.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/cart_product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: false,
        titleTextStyle: AppTheme.appBarTitleStyle,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          // if (controller.isLoading) {
          //   return const Loading();
          // }
          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshData();
            },
            child: (controller.cartProducts.isEmpty && !controller.isLoading)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomCenteredText(
                        "You Haven't Added Any Product To Cart",
                      ),
                      TextButton(
                        onPressed: () {
                          Get.find<HomeController>().navigateToIndex(0);
                        },
                        child: const Text("Add Some"),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    separatorBuilder: (_, __) {
                      return const Gap(height: 10);
                    },
                    itemBuilder: (context, index) {
                      if (controller.isLoading) {
                        return const CartProductShimmer();
                      }
                      return CartProductCard(
                        controller.cartProducts[index],
                        onIncrement: () => controller
                            .incrementQuantity(controller.cartProducts[index]),
                        onDecrement: () => controller
                            .decrementQuantity(controller.cartProducts[index]),
                        onDelete: () {
                          controller.deleteCartProduct(
                              controller.cartProducts[index]);
                        },
                      );
                    },
                    itemCount: controller.isLoading
                        ? (Get.height ~/ (Get.height * .17))
                        : controller.cartProducts.length,
                  ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        if (controller.cartProducts.isEmpty || controller.isLoading) {
          return const Gap();
        }
        return Container(
          // color: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: Get.statusBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total",
                    style: Get.textTheme.headline4
                        ?.copyWith(color: Colors.black54),
                  ),
                  Text(
                    "\$${controller.cartProducts.isEmpty ? 0 : controller.totalPrice}",
                    style: Get.textTheme.headline3
                        ?.copyWith(color: Get.theme.primaryColor),
                  ),
                ],
              ),
              CustomButton(
                text: "Checkout",
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.checkout,
                    arguments: {
                      "price": controller.totalPrice,
                      "products": controller.cartProducts,
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
