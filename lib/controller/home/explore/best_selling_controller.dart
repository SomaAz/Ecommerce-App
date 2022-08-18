import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BestSellingController extends GetxController {
  List<ProductModel> bestSellingProducts = [];
  List<String> bestSellingProductsIds = [];

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

    //get best selling products ids
    final fetchedProductsIds =
        await productsRepository.getBestSellingProductsIds();

    bestSellingProductsIds = fetchedProductsIds;

    //get best selling products
    final fetchedProducts = await productsRepository.getBestSellingProducts(
      bestSellingProductsIds: bestSellingProductsIds,
      limit: 6,
    );

    bestSellingProducts = fetchedProducts;

    setIsLoading(false);
  }

  Future<void> refreshData() async {
    final refreshedProducts = await productsRepository.getBestSellingProducts(
      bestSellingProductsIds: bestSellingProductsIds,
      limit: bestSellingProducts.length,
    );

    bestSellingProducts = refreshedProducts;

    update();
  }

  Future<void> loadMore() async {
    if (hasNextPage && !isLoading && !isLoadMoreRunning && _isExtentAfter) {
      setIsLoadMoreRunning(true);

      final fetchedProducts = await productsRepository.getBestSellingProducts(
        bestSellingProductsIds: bestSellingProductsIds,
        startAfterProductName: bestSellingProducts.last.name,
        limit: 6,
      );

      if (fetchedProducts.isNotEmpty) {
        bestSellingProducts.addAll(fetchedProducts);
      } else {
        setHasNextPage(false);
      }
      setIsLoadMoreRunning(false);
    }
  }

  @override
  void onInit() async {
    loadData();
    scrollController = ScrollController(initialScrollOffset: productCardHeight);
    scrollController.addListener(loadMore);
    super.onInit();
  }
}
