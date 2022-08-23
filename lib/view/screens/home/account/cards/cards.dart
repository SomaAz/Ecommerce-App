import 'package:awesome_card/awesome_card.dart';
import 'package:ecommerce_getx/controller/home/account/cards_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_credit_card.dart';
import 'package:ecommerce_getx/view/widgets/custom_radio.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSliverLayout(
        title: "Cards",
        children: [
          GetBuilder<CardsController>(
            builder: (controller) {
              // if (controller.isLoading) {
              //   return SizedBox(
              //     height: remainingScreenHeight,
              //     child: const Loading(),
              //   );
              // }

              if (controller.cards.isEmpty && !controller.isLoading) {
                return SizedBox(
                  height: remainingScreenHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "There Are No Cards",
                        style: Get.textTheme.headline5,
                      ),
                      const GapH(20),
                      CustomButton(
                        text: "New",
                        onPressed: () {
                          Get.toNamed(AppRoutes.newCard);
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
                separatorBuilder: (_, __) => const GapH(20),
                itemBuilder: (context, index) {
                  if (controller.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ShimmerWidget(
                        width: double.infinity,
                        height: Get.height * .24,
                        borderRadius: 15,
                      ),
                    );
                  }
                  return Get.arguments?['fromCheckout'] != null
                      ? CustomCreditCard.radio(
                          controller.cards[index],
                          selectedCard: controller.selectedCard,
                          onChanged: controller.setSelectedCard,
                          onDelete: controller.deleteCard,
                          onEdit: (card) {
                            Get.toNamed(
                              AppRoutes.editCard,
                              arguments: {"card": card},
                            );
                          },
                        )
                      : CustomCreditCard(
                          controller.cards[index],
                          onDelete: controller.deleteCard,
                          onEdit: (card) {
                            Get.toNamed(
                              AppRoutes.editCard,
                              arguments: {"card": card},
                            );
                          },
                        );
                },
                itemCount: controller.isLoading ? 3 : controller.cards.length,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CardsController>(
        builder: (controller) {
          if (controller.cards.isEmpty) return const Gap();
          return SizedBox(
            height: Get.statusBarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Get.arguments?['fromCheckout'] != null
                  ? Center(
                      child: CustomButton(
                        text: "Select",
                        onPressed: () {
                          Get.back(result: controller.selectedCard);
                        },
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          text: "New",
                          onPressed: () {
                            Get.toNamed(AppRoutes.newCard);
                          },
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class CustomCreditCardRadio extends StatelessWidget {
  const CustomCreditCardRadio({
    required this.card,
    required this.selectedCard,
    required this.onChanged,
    this.showBackSide = false,
    Key? key,
  }) : super(key: key);

  final CardModel card;
  final bool showBackSide;
  final CardModel selectedCard;
  final void Function(CardModel) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCreditCard(
          card,
          showBackSide: showBackSide,
        ),
        CustomRadio<CardModel>(
          value: card,
          groupValue: selectedCard,
          onChanged: onChanged,
          text: "Selected",
          // activeColor: Get.theme.primaryColor,
        )
      ],
    );
  }
}
