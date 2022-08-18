import 'dart:developer';

import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/controller/home/favorites_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final ProductModel product;
  final String heroTagAdditon;

  ProductDetailsController()
      : product = Get.arguments['product'],
        heroTagAdditon = Get.arguments['heroTagAddition'] ?? "" {
    if (product.sizes.isNotEmpty) selectedSize = product.sizes[0].obs;
    if (product.colors.isNotEmpty) selectedColor = product.colors[0].obs;
    // isFavorite = product.favorites
    //     .contains(FirebaseAuthRepository.firebaseAuth.currentUser!.uid);
  }

  //! That's Not A Real Part Of The App
  //! It's Just For Making The Error Of
  //! GetX Usage Doesn't Show
  RxBool errorCloser = true.obs;

  late Rx<String> selectedSize;
  late Rx<Color> selectedColor;

  void changeSelectedSize(String? size) {
    if (size != null) selectedSize.value = size;
  }

  void changeSelectedColor(Color? color) {
    if (color != null) selectedColor.value = color;
  }

  bool get isFavorite {
    return product.favorites
        .contains(FirebaseAuthRepository.firebaseAuth.currentUser!.uid);
  }

  bool get isAddedToCart {
    return Get.find<CartController>()
        .cartProducts
        .map((cartProduct) => cartProduct.id)
        .contains(product.id);
  }

  Future<void> toggleFavorite() async {
    await favoritesRepository.toggleFavorite(product).then((value) {
      Get.find<FavoritesController>().refreshData();
      update();
    });
  }

  Future<void> addProductToCart() async {
    if (!isAddedToCart) {
      try {
        await cartsRepository.addProductToCart(product.toCartProductModel());
        //? Refresh Data In The Cart Screen
        await Get.find<CartController>().refreshData();
        Get.snackbar("Success", "Product Has Been Added To Cart");
      } catch (e) {
        log(e.toString());
      }
      update();
    }
  }
}
