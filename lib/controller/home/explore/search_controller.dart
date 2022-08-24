import 'dart:async';
import 'dart:developer';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool isSearching = false;

  // late final ScrollController scrollController;

  // bool get _isExtentAfter => scrollController.position.extentAfter < 300;

  List<ProductModel> products = [];

  List<ProductModel> searchedProducts = [];

  String searchText = "";

  void setSearchText(String value) {
    searchText = value;
    update();
  }

  void setIsLoadMoreRunning(bool value) {
    isLoadMoreRunning = value;
    update();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    update();
  }

  void setIsSearching(bool value) {
    isSearching = value;
    update();
  }

  Timer? _searchOnStoppedTyping;

  void onChangeSearchHandler(String value) {
    searchText = value;

    const duration = Duration(
      milliseconds: 250,
    ); // set the duration that you want call search() after that.
    if (_searchOnStoppedTyping != null) {
      _searchOnStoppedTyping!.cancel(); // clear timer
    }
    _searchOnStoppedTyping = Timer(
      duration,
      () {
        _search(value);
      },
    );
  }

  Future<void> _search(String value) async {
    // setIsSearching(true);
    // setSearchText(value);
    // final fetchedProducts =
    //     await productsRepository.searchProducts(value, limit: 2);
    // searchedProducts = fetchedProducts;
    // print(searchedProducts.length);

    // setIsSearching(false);
    searchedProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  Future<void> loadData() async {
    setIsSearching(true);
    final fetchedProducts =
        await AppRepositories.productsRepository.getAllProducts();
    products = fetchedProducts;
    setIsSearching(false);
  }

  Future<void> loadMore() async {
    // log("hasNextPage:$hasNextPage");
    // log("isSearching:$isSearching");
    // log("isLoadMoreRunning:$isLoadMoreRunning");
    // log("_isExtentAfter:$_isExtentAfter");
    // log("_isExtentAfter:$_isExtentAfter");
    // log("searchedProducts.isNotEmpty:${searchedProducts.isNotEmpty}");
    // log("searchText.isNotEmpty:${searchText.isNotEmpty}");

    // print(hasNextPage &&
    //     !isSearching &&
    //     !isLoadMoreRunning &&
    //     _isExtentAfter &&
    //     searchedProducts.isNotEmpty &&
    //     searchText.isNotEmpty);

    if (hasNextPage &&
        !isSearching &&
        !isLoadMoreRunning &&
        // _isExtentAfter &&
        searchedProducts.isNotEmpty &&
        searchText.isNotEmpty) {
      setIsLoadMoreRunning(true);

      final fetchedProducts =
          await AppRepositories.productsRepository.searchProducts(
        searchText,
        startAfterProductName: searchedProducts.last.name,
        limit: 2,
      );
      log("${fetchedProducts.length}");
      if (fetchedProducts.isNotEmpty) {
        searchedProducts.addAll(fetchedProducts);
      } else {
        print("hell ");
        setHasNextPage(false);
      }
      setIsLoadMoreRunning(false);
    }
  }

  @override
  void onInit() async {
    loadData();
    // scrollController = ScrollController(initialScrollOffset: productCardHeight);
    // scrollController.addListener(loadMore);
    super.onInit();
  }
}
