import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/view/widgets/product_card.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(
    this.products, {
    this.productCardHeroTagAddition = "productsGrird",
    this.scrollable = false,
    Key? key,
    this.controller,
    this.isLoading = false,
  }) : super(key: key);

  final List<ProductModel> products;
  final ScrollController? controller;
  final String productCardHeroTagAddition;
  final bool scrollable;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    // return Infinitescro
    return GridView.builder(
      shrinkWrap: !scrollable,
      controller: controller,
      physics: scrollable ? null : const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // mainAxisExtent: productCardHeight,
        mainAxisExtent: Get.height * .3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (isLoading) return const Center(child: ProductShimmer());
        return Center(
          child: ProductCard(
            products[index],
            heroTagAddition: productCardHeroTagAddition,
          ),
        );
      },
      itemCount:
          isLoading ? Get.height ~/ productCardHeight * 2 : products.length,
    );
  }
}
