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
          child: Column(
            children: [
              SearchTextField(
                autofocus: true,
                icon: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.cancel_outlined),
                ),
                onChanged: controller.onChangeSearchHandler,
                hint: "Search",
              ),
              const GapH(20),
              GetX<SearchController>(builder: (controller) {
                if (controller.isLoading.value) {
                  return const Loading();
                }

                return ProductsGrid(controller.searchedProducts.toList());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
