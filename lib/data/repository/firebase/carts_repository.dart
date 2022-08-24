import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class ProductsRepositoryBase {
  Future<List<CartProductModel>> getAllCartProducts();
  Future<void> addProductToCart(CartProductModel cartProductModel);
  Future<void> incrementQuantity(CartProductModel cartProductModel);
  Future<void> decrementQuantity(CartProductModel cartProductModel);
  Future<void> deleteCartProduct(CartProductModel cartProductModel);
  Future<void> clearProducts();
}

class CartsRepository extends ProductsRepositoryBase {
  static final CartsRepository instance = CartsRepository._();
  CartsRepository._();

  final _cartCollection = AppRepositories.firestore
      .collection("users")
      .doc(FirebaseAuthRepository.firebaseAuth.currentUser!.uid)
      .collection("cart");

  @override
  Future<List<CartProductModel>> getAllCartProducts() async {
    final snapshot = await _cartCollection.orderBy("name").get();

    final docs = snapshot.docs;

    final products =
        docs.map((doc) => CartProductModel.fromMap(doc.data())).toList();

    return products;
  }

  @override
  Future<void> addProductToCart(CartProductModel cartProductModel) async {
    final ref = _cartCollection.doc(cartProductModel.id.trim());

    final snapshot = await ref.get();
    if (snapshot.exists) {
      log("Product Is Already Added To Cart");
    } else {
      await ref.set(cartProductModel.toMap());
    }
  }

  @override
  Future<void> incrementQuantity(CartProductModel cartProductModel) async {
    final docRef = _cartCollection.doc(cartProductModel.id.trim());
    await docRef.update({"quantity": FieldValue.increment(1)});

    cartProductModel.quantity += 1;
  }

  @override
  Future<void> decrementQuantity(CartProductModel cartProductModel) async {
    final docRef = _cartCollection.doc(cartProductModel.id.trim());
    if (cartProductModel.quantity > 1) {
      // if ((await docRef.get()).data()!['quantity'] > 1) {
      await docRef.update(
        {"quantity": FieldValue.increment(-1)},
      );

      cartProductModel.quantity -= 1;
    }
    // }
  }

  @override
  Future<void> deleteCartProduct(CartProductModel cartProductModel) async {
    await _cartCollection.doc(cartProductModel.id.trim()).delete();
  }

  @override
  Future<void> clearProducts() async {
    final snapshot = await _cartCollection.get();
    final batch = AppRepositories.firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
