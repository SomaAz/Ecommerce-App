import 'dart:developer';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';

abstract class ProductsRepositoryBase {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsOfCategory(String categoryId);
  Future<List<ProductModel>> getBestSellingProducts({
    required List<String> bestSellingProductsIds,
  });
  Future<List<String>> getBestSellingProductsIds();
  Future<List<ProductModel>> searchProducts(String searchText);
}

class ProductsRepository extends ProductsRepositoryBase {
  static final ProductsRepository instance = ProductsRepository._();
  ProductsRepository._();

  static final _productsCollection =
      AppRepositories.firestore.collection("products");

  @override
  Future<List<ProductModel>> getAllProducts({
    String? startAfterProductName,
    int? limit,
  }) async {
    var query = _productsCollection.orderBy("name");

    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfterProductName != null) {
      query = query.startAfter([startAfterProductName]);
    }

    final snapshot = await query.get();
    final docs = snapshot.docs;
    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }

  @override
  Future<List<ProductModel>> getProductsOfCategory(
    String categoryId, {
    String? startAfterProductName,
    int limit = 5,
  }) async {
    var query = _productsCollection
        .orderBy("name")
        .where("category", isEqualTo: categoryId)
        .limit(limit);

    if (startAfterProductName != null) {
      query = query.startAfter([startAfterProductName]);
    }

    final snapshot = await query.get();
    final docs = snapshot.docs;
    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }

  @override
  Future<List<ProductModel>> getBestSellingProducts({
    required List<String> bestSellingProductsIds,
    String? startAfterProductName,
    int limit = 5,
  }) async {
    var query = _productsCollection
        .orderBy("name")
        .where("id", whereIn: bestSellingProductsIds)
        .limit(limit);

    if (startAfterProductName != null) {
      query = query.startAfter([startAfterProductName]);
    }

    final snapshot = await query.get();
    final docs = snapshot.docs;
    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }

  @override
  Future<List<String>> getBestSellingProductsIds() async {
    //?Get All Orders To Start Calculating The Best Selling Products
    final orders =
        await AppRepositories.ordersRepository.getNotCanceledOrders();

    //?Mapping The Orders To Products (With Duplicates)
    final ordersProducts =
        orders.map((order) => order.products).reduce((a, b) => a + b);

    //? Get The Products With The Quantity Summed
    final productsWithFullQuantity =
        ordersProducts.toSet().map((fullQuantityProduct) {
      return fullQuantityProduct.copyWith(
          quantity: ordersProducts
              .where((product) => product.id == fullQuantityProduct.id)
              .map((e) => e.quantity)
              .reduce((a, b) => a + b));
    }).toList();

    //?Get The Quantity Of All Products Reduced To
    //?Calculate The Average Quantity For Products
    final allProductsQuantity = ordersProducts
        .map((product) => product.quantity)
        .reduce((a, b) => a + b);

    //?Calculate The Average Quantity For Products By
    //?Dividing The Quantity Of All Products By The Number Of Products
    final averageQuantity =
        allProductsQuantity / productsWithFullQuantity.length;

    final bestSellingProducts = productsWithFullQuantity
        .where((product) => product.quantity >= averageQuantity)
        .toList();

    final bestSellingProductsIds =
        bestSellingProducts.map((e) => e.id).toList();

    return bestSellingProductsIds;
  }

  @override
  Future<List<ProductModel>> searchProducts(
    String searchText, {
    String? startAfterProductName,
    int limit = 5,
  }) async {
    log("Searching For $searchText...");
    var query = _productsCollection
        .orderBy("name")
        .where("name", isGreaterThanOrEqualTo: searchText)
        .limit(limit);

    if (startAfterProductName != null) {
      query = query.startAfter([startAfterProductName]);
    }

    final snapshot = await query.get();
    final docs = snapshot.docs;
    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }
}
