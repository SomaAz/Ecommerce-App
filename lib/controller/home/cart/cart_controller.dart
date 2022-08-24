import 'dart:async';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<CartProductModel> cartProducts = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // bool _isRefreshing = false;
  // bool get isRefreshing => _isRefreshing;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  // void setIsRefreshing(bool value) {
  //   _isRefreshing = value;
  //   update();
  // }

  Future<void> getCartProducts() async {
    cartProducts =
        await AppRepositories.cartsRepository.getAllCartProducts().onError(
      (error, stackTrace) {
        return [];
      },
    );
  }

  Timer? _incrementOnStoppedPressing;
  Timer? _decrementOnStoppedPressing;

  //? This For Keeping The Value Of Quantity In The Repository Correct
  bool _isDecrementing = false;

  Future<void> incrementQuantity(CartProductModel cartProductModel) async {
    // const duration = Duration(
    //   milliseconds: 250,
    // ); // set the duration that you want call search() after that.
    // if (_incrementOnStoppedPressing != null) {
    //   _incrementOnStoppedPressing!.cancel(); // clear timer
    // }
    // _incrementOnStoppedPressing = Timer(
    //   duration,
    //   () async {
    await AppRepositories.cartsRepository
        .incrementQuantity(cartProductModel)
        .then((value) => update());
    // },
    // );
  }

  Future<void> decrementQuantity(CartProductModel cartProductModel) async {
    // cartProductModel.quantity--;
    // update();

    // const duration = Duration(
    //   milliseconds: 250,
    // ); // set the duration that you want call search() after that.
    // if (_incrementOnStoppedPressing != null) {
    //   _incrementOnStoppedPressing!.cancel(); // clear timer
    // }
    // _incrementOnStoppedPressing = Timer(
    //   duration,
    //   () async {
    //     await cartsRepository
    //         .decrementQuantity(cartProductModel)
    //         .then((value) => update());
    //   },
    // );
    if (!_isDecrementing) {
      _isDecrementing = true;
      await AppRepositories.cartsRepository
          .decrementQuantity(cartProductModel)
          .then((value) => update());
    }
    _isDecrementing = false;
  }

  Future<void> deleteCartProduct(CartProductModel cartProductModel) async {
    AppFunctions.showChoiceDialog(
      text: "Are Sure You Wan't To Delete This Product From Cart?",
      onConfirm: () {
        AppRepositories.cartsRepository
            .deleteCartProduct(cartProductModel)
            .then(
          (value) {
            cartProducts.remove(cartProductModel);
            update();
          },
        );
        Get.back();
      },
    );
  }

  Future<void> clearCartProducts() async {
    await AppRepositories.cartsRepository.clearProducts().then((value) {
      cartProducts.clear();
      update();
    });
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getCartProducts();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await getCartProducts();
    update();
  }

  double get totalPrice {
    return cartProducts
        .map((cartProduct) => cartProduct.price * cartProduct.quantity)
        .reduce((a, b) => a + b);
  }

  @override
  void onInit() async {
    loadData();
    super.onInit();
  }
}
