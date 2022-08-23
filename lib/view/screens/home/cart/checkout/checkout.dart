import 'package:ecommerce_getx/controller/home/cart/checkout/checkout_controller.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/view/screens/home/cart/checkout/delivery.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_credit_card.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/section_title.dart';
import 'package:ecommerce_getx/view/widgets/shipping_address_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      body: GetBuilder<CheckoutController>(
        builder: (controller) {
          if (controller.isLoading) return const Loading();
          return CustomSliverLayout(
            title: "Checkout",
            children: [
              ListView(
                controller: scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SectionTitle.withWidget(
                    "Shipping Address",
                    TextButton(
                      onPressed: controller.changeSelectedUserAddress,
                      child: const Text("Change"),
                    ),
                    withPadding: false,
                  ),
                  // const GapH(10),
                  controller.selectedShippingAddress == null
                      ? Text(
                          "You Don't Have Any Shipping Address, Add One",
                          style: Get.textTheme.headline6,
                        )
                      : ShippingAddressCard(
                          controller.selectedShippingAddress!,
                          haveActions: false,
                        ),

                  const GapH(30),
                  SectionTitle.withWidget(
                    "Payment",
                    TextButton(
                      onPressed: controller.changeSelectedUserCard,
                      child: const Text("Change"),
                    ),
                    withPadding: false,
                  ),
                  const GapH(10),
                  controller.selectedCard == null
                      ? Text(
                          "You Don't Have Any Shipping Address, Add One",
                          style: Get.textTheme.headline6,
                        )
                      : CustomCreditCard(
                          controller.selectedCard!,
                          hideNumber: true,
                        ),
                  const GapH(35),
                  const SectionTitle(
                    "Delivery",
                    withPadding: false,
                  ),
                  const GapH(20),
                  DeliveryTypeCard(
                    title: "Standard Delivery",
                    description:
                        "Order will be delivered between 3 - 5 business days",
                    onChanged: controller.changeDeliveryType,
                    deliveryType: DeliveryType.standard,
                    selectedDeliveryType: controller.selectedDeliveryType,
                  ),
                  const GapH(10),
                  DeliveryTypeCard(
                    title: "Next Day Delivery",
                    description:
                        "Place your order before 6pm and your items will be delivered the next day",
                    onChanged: controller.changeDeliveryType,
                    deliveryType: DeliveryType.nextDay,
                    selectedDeliveryType: controller.selectedDeliveryType,
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar:
          GetBuilder<CheckoutController>(builder: (controller) {
        // if (controller.cartProducts.isEmpty) return const Gap();

        return Container(
          // alignment: Alignment.bottomCenter, // color: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0), blurRadius: 5, color: Colors.black12
                  // spreadRadius: 10,
                  )
            ],
          ),
          // height: Get.statusBarHeight * 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: Get.width,
              // color: Colors.blue,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PriceRow(text: "Order", price: controller.orderPrice),
                  const GapH(15),
                  _PriceRow(
                    text: "Delivery",
                    price: controller.deliveryPrice,
                  ),
                  const GapH(20),
                  _PriceRow(
                    text: "Total",
                    price: controller.totalPrice,
                    isFontBold: true,
                  ),
                  const GapH(10),
                  SizedBox(
                    width: double.infinity,
                    child: controller.isPlacingOrderLoading
                        ? const Loading()
                        : CustomButton(
                            text: "Place Order",
                            onPressed: () {
                              controller.placeOrder();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    Key? key,
    required this.text,
    required this.price,
    this.isFontBold = false,
  }) : super(key: key);
  final String text;
  final double price;
  final bool isFontBold;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$text:",
          style: isFontBold ? Get.textTheme.headline3 : Get.textTheme.headline4,
        ),
        Text(
          "\$$price",
          style: isFontBold
              ? Get.textTheme.headline3!.copyWith(color: Get.theme.primaryColor)
              : Get.textTheme.headline4!
                  .copyWith(color: Get.theme.primaryColor),
        ),
      ],
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//

class CustomStatusChangeIndicator extends StatelessWidget {
  const CustomStatusChangeIndicator({
    this.itemsCount = 0,
    this.currentStep = 0,
    required this.titles,
    Key? key,
  })  : assert(titles.length == itemsCount),
        super(key: key);

  final int itemsCount;
  final int currentStep;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            itemsCount,
            (index) => SizedBox(
              // width: Get.width / titles.length,
              child: CustomStatusChangeNode(
                hasLine: index < titles.length - 1,
                completed: currentStep >= index,
                activeColor: Get.theme.primaryColor,
                inActiveColor: Colors.grey.shade400,
                title: titles[index],
                numberOfPages: titles.length,
              ),
            ),
          ),
        ),
        const GapH(6),
        ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: List.generate(
                itemsCount,
                (index) => Text(
                  titles[index],
                  style: TextStyle(
                    color: currentStep >= index ? Colors.black : null,
                    fontSize: currentStep >= index ? 14 : 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomStatusChangeNode extends StatelessWidget {
  const CustomStatusChangeNode({
    this.hasLine = true,
    this.completed = false,
    this.activeColor = Colors.green,
    this.inActiveColor = Colors.grey,
    required this.title,
    required this.numberOfPages,
    Key? key,
  }) : super(key: key);

  final bool hasLine;
  final bool completed;
  final Color activeColor;
  final Color inActiveColor;
  final String title;
  final int numberOfPages;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.width),
            border: completed
                ? null
                : Border.all(
                    color: completed ? activeColor : inActiveColor,
                    width: 1,
                  ),
            color: completed ? activeColor : Colors.white,
          ),
        ),
        // if (!hasLine) GapW(10),
        if (hasLine)
          Container(
            height: completed ? 2 : 1,
            color: completed ? activeColor : inActiveColor,
            width: Get.width / numberOfPages,
          ),
      ],
    );
  }
}
