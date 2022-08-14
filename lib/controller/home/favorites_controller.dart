import 'package:ecommerce_getx/controller/home/explore/explore_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  List<ProductModel> favoritedProducts = [];

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

  Future<void> getFavoritedProducts() async {
    favoritedProducts =
        await favoritesRepository.getAllFavoritedProducts().onError(
      (error, stackTrace) {
        return [];
      },
    );
  }

  Future<void> deleteProductFromFavorites(ProductModel productModel) async {
    await favoritesRepository.deleteProductFromFavorites(productModel).then(
      (value) {
        favoritedProducts.remove(productModel);
        update();
        Get.find<ExploreController>().refreshData();
      },
    );
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getFavoritedProducts();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await getFavoritedProducts();
    update();
  }

  @override
  void onInit() async {
    loadData();
    super.onInit();
  }
}
