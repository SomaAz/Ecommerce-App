import 'package:ecommerce_getx/controller/home/cart/checkout/checkout_controller.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/view/widgets/custom_radio.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DelvieryPage extends StatelessWidget {
  const DelvieryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckoutController>(
        builder: (controller) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              DeliveryTypeCard(
                title: "Standard Delivery",
                description:
                    "Order will be delivered between 3 - 5 business days",
                onChanged: controller.changeDeliveryType,
                deliveryType: DeliveryType.standard,
                selectedDeliveryType: controller.selectedDeliveryType,
              ),
              const GapH(50),
              DeliveryTypeCard(
                title: "Next Day Delivery",
                description:
                    "Place your order before 6pm and your items will be delivered the next day",
                onChanged: controller.changeDeliveryType,
                deliveryType: DeliveryType.nextDay,
                selectedDeliveryType: controller.selectedDeliveryType,
              ),
              const GapH(50),
              // DeliveryTypeCard(
              //   title: "Nominated Delivery",
              //   description:
              //       "Pick a particular date from the calendar and order will be delivered on selected date",
              //   onChanged: controller.changeDeliveryType,
              //   deliveryType: DeliveryType.nominated,
              //   selectedDeliveryType: controller.selectedDeliveryType,
              // ),
            ],
          );
        },
      ),
    );
  }
}

class DeliveryTypeCard extends StatelessWidget {
  const DeliveryTypeCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onChanged,
    required this.deliveryType,
    required this.selectedDeliveryType,
  }) : super(key: key);

  final DeliveryType deliveryType;
  final DeliveryType selectedDeliveryType;
  final String title;
  final String description;
  final void Function(DeliveryType) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              const GapH(8),
              Text(
                description,
                style: Get.textTheme.bodyText1!
                    .copyWith(color: Colors.black, height: 1.6),
              ),
            ],
          ),
        ),
        const GapW(20),
        CustomRadio<DeliveryType>(
          value: deliveryType,
          groupValue: selectedDeliveryType,
          onChanged: onChanged,
          // activeColor: Get.theme.primaryColor,
        )
      ],
    );
  }
}
