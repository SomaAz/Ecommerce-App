import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:get/get.dart';

class CategoryDetailsController extends GetxController {
  final CategoryModel category;

  CategoryDetailsController() : category = Get.arguments;

  List<ProductModel> products = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> getProductsOfCategory() async {
    products = await productsRepository
        .getProductsOfCategory(category.id)
        .then((products) {
      return products;
    }).onError((error, stackTrace) {
      return [];
    });
  }

  Future<void> loadData() async {
    setIsLoading(true);

    await getProductsOfCategory();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await getProductsOfCategory();
    update();
  }

  @override
  void onReady() async {
    await loadData();
    super.onReady();
  }
}
