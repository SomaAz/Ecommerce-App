import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';

abstract class CategoriesRepositoryBase {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoriesRepository extends CategoriesRepositoryBase {
  static final CategoriesRepository instance = CategoriesRepository._();
  CategoriesRepository._();

  static final _categoriesCollection =
      AppRepositories.firestore.collection("categories");

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _categoriesCollection.get();

    final docs = snapshot.docs;

    final categories =
        docs.map((doc) => CategoryModel.fromMap(doc.data())).toList();

    return categories;
  }
}
