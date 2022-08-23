import 'package:ecommerce_getx/controller/home/explore/best_selling_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BestSellingScreen extends StatelessWidget {
  const BestSellingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BestSellingController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: CustomSliverLayout(
          title: "Best Selling",
          controller: controller.scrollController,
          children: [
            GetBuilder<BestSellingController>(
              builder: (controller) {
                // if (controller.isLoading) {
                //   return SizedBox(
                //     height: remainingScreenHeight,
                //     child: const Loading(),
                //   );
                // }
                if (controller.bestSellingProducts.isEmpty &&
                    !controller.isLoading) {
                  return SizedBox(
                    height: remainingScreenHeight,
                    child: Center(
                      child: Text(
                        "There Are No Products",
                        style: Get.textTheme.headline4,
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ProductsGrid(
                      controller.bestSellingProducts,
                      productCardHeroTagAddition: "bestSelling",
                      isLoading: controller.isLoading,
                    ),
                    if (controller.isLoadMoreRunning)
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Loading(),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
