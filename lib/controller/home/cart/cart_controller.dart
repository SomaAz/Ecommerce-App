import 'package:ecommerce_getx/core/constant/constants.dart';
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
    cartProducts = await cartsRepository.getAllCartProducts().onError(
      (error, stackTrace) {
        return [];
      },
    );
  }

  //? This For Keeping The Value Of Quantity In The Repository Correct
  bool _isDecrementing = false;

  Future<void> incrementQuantity(CartProductModel cartProductModel) async {
    await cartsRepository
        .incrementQuantity(cartProductModel)
        .then((value) => update());
  }

  Future<void> decrementQuantity(CartProductModel cartProductModel) async {
    if (!_isDecrementing) {
      _isDecrementing = true;
      await cartsRepository
          .decrementQuantity(cartProductModel)
          .then((value) => update());
    }
    _isDecrementing = false;
  }

  Future<void> deleteCartProduct(CartProductModel cartProductModel) async {
    await cartsRepository.deleteCartProduct(cartProductModel).then(
      (value) {
        cartProducts.remove(cartProductModel);
        update();
      },
    );
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getCartProducts();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    // setIsRefreshing(true);
    await getCartProducts();
    update();
    // setIsRefreshing(false);
  }

  double get totalPrice {
    return cartProducts
        .map((cartProduct) => cartProduct.price * cartProduct.quantity)
        .reduce((a, b) => a + b);
  }

  @override
  void onReady() async {
    loadData();
    super.onReady();
  }
}
