import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final ProductModel product;

  ProductDetailsController() : product = Get.arguments {
    if (product.sizes.isNotEmpty) selectedSize = product.sizes[0].obs;
    if (product.colors.isNotEmpty) selectedColor = product.colors[0].obs;
  }

  //! That's Not A Real Part Of The App
  //! It's Just For Making The Error Of
  //! GetX Usage Doesn't Show
  RxBool errorCloser = true.obs;

  late Rx<String> selectedSize;
  late Rx<Color> selectedColor;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void changeSelectedSize(String? size) {
    if (size != null) selectedSize.value = size;
  }

  void changeSelectedColor(Color? color) {
    if (color != null) selectedColor.value = color;
  }
}
