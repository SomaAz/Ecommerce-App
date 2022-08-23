import 'package:ecommerce_getx/controller/home/favorites_controller.dart';
import 'package:ecommerce_getx/controller/home/home_controller.dart';
import 'package:ecommerce_getx/core/constant/theme.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/centered_text.dart';
import 'package:ecommerce_getx/view/widgets/favorited_product_card.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/cart_product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: false,
        titleTextStyle: AppTheme.appBarTitleStyle,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: GetBuilder<FavoritesController>(
            builder: (controller) {
              // if (controller.isLoading) {
              //   return const Loading();
              // }
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshData();
                },
                child: controller.favoritedProducts.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomCenteredText(
                            "You Haven't Added Any Product To Favorite",
                          ),
                          TextButton(
                            onPressed: () {
                              Get.find<HomeController>().navigateToIndex(0);
                            },
                            child: const Text("Discover Products"),
                          ),
                        ],
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (_, __) {
                          return const Gap(height: 10);
                        },
                        itemBuilder: (context, index) {
                          if (controller.isLoading) {
                            return const CartProductShimmer();
                          }

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
                        itemCount: controller.isLoading
                            ? (Get.height ~/ (Get.height * .17))
                            : controller.favoritedProducts.length,
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
