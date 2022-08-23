import 'package:ecommerce_getx/controller/home/explore/best_selling_controller.dart';
import 'package:ecommerce_getx/controller/home/explore/explore_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/view/widgets/centered_text.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/explore/category_card.dart';
import 'package:ecommerce_getx/view/widgets/search_textfield.dart';
import 'package:ecommerce_getx/view/widgets/section_title.dart';
import 'package:ecommerce_getx/view/widgets/product_card.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/category_shimmer.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ExploreController>(
          builder: (controller) {
            // if (controller.isLoading) {
            //   return const Loading();
            // }
            return RefreshIndicator(
              onRefresh: () async {
                await controller.refreshData();
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchTextField(
                          onTap: () {
                            Get.toNamed(AppRoutes.search);
                          },
                          hint: "Search",
                          // enableInteractiveSelection: false,
                          readOnly: true,
                          // enabled: false,
                        ),
                        const GapH(50),
                      ],
                    ),
                  ),
                  const _CategoriesSection(),
                  const GapH(30),
                  const _BestSellingSection()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//?-------------------------------- Sections ----------------------------------
class _BestSellingSection extends StatelessWidget {
  const _BestSellingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BestSellingController>(
      builder: (bestSellingController) {
        final itemCount = bestSellingController.isLoading
            ? 10
            : bestSellingController.bestSellingProducts.length > 6
                ? 6
                : bestSellingController.bestSellingProducts.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle.withWidget(
              "Best Selling",
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.bestSelling);
                },
                child: const Text(
                  "See All",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const GapH(15),
            (bestSellingController.bestSellingProducts.isEmpty &&
                    !bestSellingController.isLoading)
                ? const CustomCenteredText(
                    "There Are No Products In Best Selling Section",
                  )
                : SizedBox(
                    height: productCardHeight,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 15),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: itemCount,
                      separatorBuilder: (context, index) {
                        return const GapW(12);
                      },
                      itemBuilder: (context, index) {
                        if (bestSellingController.isLoading) {
                          return const ProductShimmer();
                        }
                        return ProductCard(
                          bestSellingController.bestSellingProducts[index],
                          heroTagAddition: "bestSelling",
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle("Categories"),
        const GapH(15),
        SizedBox(
          height: Get.height * .13,
          child: GetBuilder<ExploreController>(builder: (controller) {
            return ListView.separated(
              padding: const EdgeInsets.only(left: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount:
                  controller.isLoading ? 8 : controller.categories.length,
              separatorBuilder: (_, __) => const GapW(10),
              itemBuilder: (context, index) {
                if (controller.isLoading) {
                  return const CategoryShimmer();
                }
                return CategoryCard(controller.categories[index]);
              },
            );
          }),
        ),
      ],
    );
  }
}
