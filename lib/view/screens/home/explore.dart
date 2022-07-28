import 'package:ecommerce_getx/controller/home/explore_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/explore/category_card.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/search_textfield.dart';
import 'package:ecommerce_getx/view/widgets/section_title.dart';
import 'package:ecommerce_getx/view/widgets/product_card.dart';
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
            if (controller.isLoading) {
              return const Loading();
            }
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
                  const GapH(50),
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
class _BestSellingSection extends GetView<ExploreController> {
  const _BestSellingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle.withWidget(
          "Best Selling",
          TextButton(
              onPressed: () {},
              child: const Text(
                "See All",
                style: TextStyle(fontSize: 18),
              )),
        ),
        const GapH(15),
        SizedBox(
          height: productCardHeight,
          child: GetBuilder<ExploreController>(
            builder: (controller) {
              return ListView.separated(
                padding: const EdgeInsets.only(left: 15),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.bestSellingProducts.length,
                separatorBuilder: (context, index) {
                  return const GapW(12);
                },
                itemBuilder: (context, index) {
                  return ProductCard(controller.bestSellingProducts[index]);
                },
              );
            },
          ),
        ),
      ],
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
          height: Get.height * .12,
          child: GetBuilder<ExploreController>(builder: (controller) {
            return ListView.builder(
              padding: const EdgeInsets.only(left: 15),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(controller.categories[index]);
              },
            );
          }),
        ),
      ],
    );
  }
}
