import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';

abstract class ProductsRepositoryBase {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsOfCategory(String categoryId);
}

class ProductsRepository extends ProductsRepositoryBase {
  static final ProductsRepository instance = ProductsRepository._();
  ProductsRepository._();

  static final _productsCollection = firestore.collection("products");

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await _productsCollection.orderBy("name").get();

    final docs = snapshot.docs;

    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }

  @override
  Future<List<ProductModel>> getProductsOfCategory(String categoryId) async {
    final snapshot = await _productsCollection
        .orderBy("name")
        .where("category", isEqualTo: categoryId)
        .get();

    final docs = snapshot.docs;

    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }
}
