import 'package:ecommerce_getx/controller/category_details_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
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
          title: controller.category.name,
          children: [
            GetBuilder<CategoryDetailsController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return SizedBox(
                    height: remainingScreenHeight,
                    child: const Loading(),
                  );
                }
                if (controller.products.isEmpty) {
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ProductsGrid(controller.products),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliverLayout extends StatelessWidget {
  const CustomSliverLayout({
    required this.children,
    required this.title,
    this.actions,
    Key? key,
  }) : super(key: key);
  final List<Widget> children;
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: Get.height * .13,
          flexibleSpace: Column(
            children: [
              const Spacer(),
              AppBar(
                title: Text(title),
                actions: actions,
              ),
            ],
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
      ],
    );
  }
}
