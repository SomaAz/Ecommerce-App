import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/view/widgets/cart_product_card.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GetBuilder<CartController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Loading();
            }
            if (controller.cartProducts.isEmpty) {
              return const Center(
                child:
                    Text("You Haven't Added Any Product To Cart Go Add Some"),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await controller.refreshData();
              },
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                separatorBuilder: (_, __) {
                  return const Gap(height: 10);
                },
                itemBuilder: (context, index) {
                  return CartProductCard(controller.cartProducts[index]);
                },
                itemCount: controller.cartProducts.length,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        if (controller.cartProducts.isEmpty) return const Gap();

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
                    style: Get.textTheme.headline4!
                        .copyWith(color: Colors.black54),
                  ),
                  Text(
                    "\$${controller.cartProducts.isEmpty ? 0 : controller.totalPrice}",
                    style: Get.textTheme.headline3!
                        .copyWith(color: Get.theme.primaryColor),
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
