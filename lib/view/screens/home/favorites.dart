import 'package:ecommerce_getx/controller/home/favorites_controller.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
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
                      AppFunctions.showChoiceDialog(
                        text:
                            "Are You Sure You Wan't To Delete This Product From Favorites?",
                        onConfirm: () async {
                          await controller
                              .deleteProductFromFavorites(
                                controller.favoritedProducts[index],
                              )
                              .then((value) => Get.back());
                        },
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
