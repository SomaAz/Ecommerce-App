import 'dart:math';

import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:ecommerce_getx/view/widgets/shipping_address_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<ShippingAddressController>().refreshData();
        },
        child: CustomSliverLayout(
          title: "Shipping Address",
          children: [
            GetBuilder<ShippingAddressController>(
              builder: (controller) {
                print(controller.isLoading);
                // if (controller.isLoading) return const Loading();
                if (controller.addresses.isEmpty && !controller.isLoading) {
                  return SizedBox(
                    height: remainingScreenHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "There Are No Shipping Addresses",
                          style: Get.textTheme.headline5,
                        ),
                        const GapH(20),
                        CustomButton(
                          text: "New",
                          onPressed: () {
                            Get.toNamed(AppRoutes.newShippingAddress);
                          },
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const GapH(40),
                  itemBuilder: (context, index) {
                    if (controller.isLoading) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget(
                            width: Get.width *
                                (AppFunctions.doubleInRange(.4, .7)),
                            height: 15,
                          ),
                          const GapH(12),
                          ShimmerWidget(
                            width: Get.width *
                                (AppFunctions.doubleInRange(.7, .95)),
                            height: 12,
                          ),
                        ],
                      );
                    }
                    return Get.arguments?['fromCheckout'] != null
                        ? ShippingAddressCard.radio(
                            controller.addresses[index],
                            onChanged: controller.setSelectedAddress,
                            selectedAddress: controller.selectedAddress,
                            onDelete: controller.deleteShippingAddress,
                            onEdit: (address) {
                              Get.toNamed(
                                AppRoutes.editShippingAddress,
                                arguments: address,
                              );
                            },
                          )
                        : ShippingAddressCard(
                            controller.addresses[index],
                            onDelete: controller.deleteShippingAddress,
                            onEdit: (address) {
                              Get.toNamed(
                                AppRoutes.editShippingAddress,
                                arguments: address,
                              );
                            },
                          );
                  },
                  itemCount: controller.isLoading
                      ? Get.height ~/ 70
                      : controller.addresses.length,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          GetBuilder<ShippingAddressController>(builder: (controller) {
        if (controller.addresses.isEmpty) return const Gap();
        return SizedBox(
          height: Get.statusBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Get.arguments?['fromCheckout'] != null
                    ? Center(
                        child: CustomButton(
                          text: "Select",
                          onPressed: () {
                            Get.back(result: controller.selectedAddress);
                          },
                        ),
                      )
                    : const Gap(),
                CustomButton(
                  text: "New",
                  onPressed: () {
                    Get.toNamed(AppRoutes.newShippingAddress);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
