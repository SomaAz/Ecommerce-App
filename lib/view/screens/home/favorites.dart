import 'dart:async';

import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/controller/home/favorites_controller.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:ecommerce_getx/view/widgets/cart_product_card.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/favorited_product_card.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GetBuilder<FavoritesController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Loading();
            }
            if (controller.favoritedProducts.isEmpty) {
              return const Center(
                child: Text(
                    "You Haven't Added Any Product To Favorites Go Add Some"),
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
                  return FavoritedProductCard(
                    controller.favoritedProducts[index],
                    onDelete: () {
                      Get.defaultDialog(
                        title: "Alert",
                        middleText:
                            "Are You Sure Wan't To Delete This Product From Favorites?",
                        onConfirm: () async {
                          await controller
                              .deleteProductFromFavorites(
                                controller.favoritedProducts[index],
                              )
                              .then(
                                (value) => Get.back(),
                              );
                        },
                        confirmTextColor: Colors.black,
                        textCancel: "cancel",
                      );
                    },
                  );
                },
                itemCount: controller.favoritedProducts.length,
              ),
            );
          },
        ),
      ),
    );
  }
}