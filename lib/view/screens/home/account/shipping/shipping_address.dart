import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_radio.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
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
                if (controller.isLoading) return const Loading();
                if (controller.addresses.isEmpty) {
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
                    return ShippingAddressCardRadio(
                      controller.addresses[index],
                      onChanged: controller.setSelectedAddress,
                      selectedAddress: controller.selectedAddress,
                    );
                  },
                  itemCount: controller.addresses.length,
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
            child: Get.previousRoute == AppRoutes.checkout
                ? Center(
                    child: CustomButton(
                      text: "Select",
                      onPressed: () {
                        Get.back(result: controller.selectedAddress);
                      },
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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

class ShippingAddressCardRadio extends StatelessWidget {
  const ShippingAddressCardRadio(
    this.address, {
    required this.onChanged,
    required this.selectedAddress,
    Key? key,
  }) : super(key: key);

  final ShippingAddressModel address;
  final ShippingAddressModel selectedAddress;
  final void Function(ShippingAddressModel) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShippingAddressCard(address),
        const GapW(30),
        CustomRadio<ShippingAddressModel>(
          value: address,
          groupValue: selectedAddress,
          onChanged: onChanged,
          // activeColor: Get.theme.primaryColor,
        )
      ],
    );
  }
}

class ShippingAddressCard extends StatelessWidget {
  const ShippingAddressCard(
    this.address, {
    Key? key,
  }) : super(key: key);

  final ShippingAddressModel address;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.name,
            style: Get.textTheme.headline4,
          ),
          const GapH(6),
          Text(
            "${address.street}, ${address.city}, ${address.state}, ${address.country}",
            style: Get.textTheme.bodyText1!
                .copyWith(color: Colors.black, height: 1.6),
          ),
        ],
      ),
    );
  }
}
