import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class ProductsRepositoryBase {
  Future<List<ProductModel>> getAllFavoritedProducts();
  Future<void> deleteProductFromFavorites(ProductModel productModel);
  Future<void> toggleFavorite(ProductModel productModel);
}

class FavoritesRepository extends ProductsRepositoryBase {
  static final FavoritesRepository instance = FavoritesRepository._();
  FavoritesRepository._();

  final uid = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;

  static final _productsCollection = firestore.collection("products");

  @override
  Future<List<ProductModel>> getAllFavoritedProducts() async {
    final snapshot = await _productsCollection
        .orderBy("name")
        .where("favorites", arrayContains: uid)
        .get();

    final docs = snapshot.docs;

    final products =
        docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    return products;
  }

  @override
  Future<void> deleteProductFromFavorites(ProductModel productModel) async {
    await _productsCollection.doc(productModel.id.trim()).update({
      "favorites": FieldValue.arrayRemove([uid]),
    }).then((value) => productModel.favorites.remove(uid));
  }

  @override
  Future<void> toggleFavorite(ProductModel productModel) async {
    final uid = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;
    final isFavorite = productModel.favorites.contains(uid);

    await _productsCollection.doc(productModel.id.trim()).update(
      {
        "favorites": isFavorite
            ? FieldValue.arrayRemove([uid])
            : FieldValue.arrayUnion([uid]),
      },
    ).then((value) {
      if (isFavorite) {
        productModel.favorites.remove(uid);
      } else {
        productModel.favorites.add(uid);
      }
      return value;
    }).onError((error, stackTrace) => Future.error);
  }
}
