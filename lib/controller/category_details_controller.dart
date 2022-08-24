import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryDetailsController extends GetxController {
  final CategoryModel category;

  CategoryDetailsController() : category = Get.arguments;

  List<ProductModel> products = [];

  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool isLoading = false;

  void setIsLoadMoreRunning(bool value) {
    isLoadMoreRunning = value;
    update();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  late final ScrollController scrollController;

  bool get _isExtentAfter => scrollController.position.extentAfter < 300;

  Future<void> loadData() async {
    setIsLoading(true);
    final fetchedProducts =
        await AppRepositories.productsRepository.getProductsOfCategory(
      category.id,
      limit: 6,
    );

    products = fetchedProducts;
    setIsLoading(false);
    scrollController.jumpTo(scrollController.offset + productCardHeight);
    scrollController.jumpTo(0);
  }

  Future<void> refreshData() async {
    final refreshedProducts =
        await AppRepositories.productsRepository.getProductsOfCategory(
      category.id,
      limit: products.length,
    );

    products = refreshedProducts;

    update();
  }

  Future<void> loadMore() async {
    if (hasNextPage && !isLoading && !isLoadMoreRunning && _isExtentAfter) {
      setIsLoadMoreRunning(true);

      final fetchedProducts =
          await AppRepositories.productsRepository.getProductsOfCategory(
        category.id,
        startAfterProductName: products.last.name,
        limit: 6,
      );

      if (fetchedProducts.isNotEmpty) {
        products.addAll(fetchedProducts);
      } else {
        setHasNextPage(false);
      }
      setIsLoadMoreRunning(false);
    }
  }

  @override
  void onInit() async {
    loadData();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
    super.onInit();
  }
}
