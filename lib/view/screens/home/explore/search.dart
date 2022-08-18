import 'package:ecommerce_getx/controller/home/explore/search_controller.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:ecommerce_getx/view/widgets/products_grid.dart';
import 'package:ecommerce_getx/view/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 0,
                child: SearchTextField(
                  autofocus: true,
                  icon: IconButton(
                    onPressed: () {
                      Get.back();
                      // Get.isRegistered<SearchController>();
                    },
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                  controller: controller.searchController,
                  onChanged: controller.onChangeSearchHandler,
                  hint: "Search",
                ),
              ),
              const GapH(20),
              Flexible(
                child: GetBuilder<SearchController>(
                  builder: (controller) {
                    if (controller.isSearching) return const Loading();

                    if (controller.searchController.text.trim().isEmpty) {
                      return Center(
                        child: Text(
                          "Type Something to Search",
                          style: Get.textTheme.headline5,
                        ),
                      );
                    }
                    if (controller.searchedProducts.isEmpty) {
                      return Center(
                        child: Text(
                          "There Are No Products Match Your Search",
                          style: Get.textTheme.headline5,
                        ),
                      );
                    }

                    return ProductsGrid(
                      controller.searchedProducts,
                      scrollable: true,
                      productCardHeroTagAddition: "search",
                      // controller: controller.scrollController,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
