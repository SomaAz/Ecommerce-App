import 'package:ecommerce_getx/controller/category_details_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryDetailsController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: CustomSliverLayout(
          title: controller.category.name.capitalizeFirst!,
          controller: controller.scrollController,
          children: [
            GetBuilder<CategoryDetailsController>(
              builder: (controller) {
                // if (controller.isLoading) {
                //   return SizedBox(
                //     height: remainingScreenHeight,
                //     child: const Loading(),
                //   );
                // }
                if (controller.products.isEmpty && !controller.isLoading) {
                  return SizedBox(
                    height: remainingScreenHeight,
                    child: Center(
                      child: Text(
                        "There Are No Products In This Category",
                        style: Get.textTheme.headline4,
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ProductsGrid(
                      controller.products,
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
