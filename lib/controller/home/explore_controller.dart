import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  List<CategoryModel> categories = [];
  List<ProductModel> bestSellingProducts = [];

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

  Future<void> getAllCategories() async {
    categories = await firestoreService.getAllCategories().onError(
      (error, stackTrace) {
        return [];
      },
    );
  }

  Future<void> getBestSellingProducts() async {
    bestSellingProducts = await firestoreService.getAllProducts().onError(
      (error, stackTrace) {
        return [];
      },
    );
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getAllCategories();
    await getBestSellingProducts();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    // setIsRefreshing(true);
    await getAllCategories();
    await getBestSellingProducts();
    update();
    // setIsRefreshing(false);
  }

  @override
  void onReady() async {
    loadData();
    super.onReady();
  }
}
