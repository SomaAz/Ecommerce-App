import 'dart:async';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;

  void setIsLoading(bool value) {
    isLoading.value = value;
  }

  Timer? searchOnStoppedTyping;

  void onChangeSearchHandler(String value) {
    const duration = Duration(
      milliseconds: 100,
    ); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel(); // clear timer
    }
    searchOnStoppedTyping = Timer(
      duration,
      () {
        _search(value);
      },
    );
  }

  void _search(String value) {
    searchedProducts.value = products
        .where(
          (product) => product.name.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
  }

  List<ProductModel> products = [];

  RxList<ProductModel> searchedProducts = RxList();

  Future<void> getAllProducts() async {
    products = await productsRepository.getAllProducts().onError(
      (error, stackTrace) {
        return [];
      },
    );
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getAllProducts();
    setIsLoading(false);
  }

  @override
  void onReady() async {
    await loadData();
    super.onReady();
  }
}
