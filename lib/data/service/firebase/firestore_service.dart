import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreServiceBase {
  Future<void> addUserToFirestore(UserModel userModel);
  Future<List<CategoryModel>> getAllCategories();
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsOfCategory(String categoryId);
}

class FirestoreService extends FirestoreServiceBase {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final FirestoreService instance = FirestoreService._();

  static final _usersCollection = firestore.collection("users");
  static final _categoriesCollection = firestore.collection("categories");
  static final _productsCollection = firestore.collection("products");

  FirestoreService._();
  //? Users Collection
  @override
  Future<void> addUserToFirestore(UserModel userModel) async {
    final userDoc = _usersCollection.doc();

    try {
      userModel = userModel.copyWith(id: userDoc.id);
      await userDoc.set(userModel.toMap());
    } catch (e) {
      userDoc.delete();

      throw FirebaseAuthException(code: "");
    }
  }

  //? Categories Collection
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _categoriesCollection.get();

    final docs = snapshot.docs;

    final categories =
        docs.map((doc) => CategoryModel.fromMap(doc.data())).toList();

    return categories;
  }

  //? Products Collection
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
