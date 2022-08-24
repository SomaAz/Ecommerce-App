import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/cards_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/carts_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/categories_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/favorites_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/orders_respository.dart';
import 'package:ecommerce_getx/data/repository/firebase/products_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/shipping_address_repository.dart';
import 'package:ecommerce_getx/data/repository/firebase/users_repository.dart';

class AppRepositories {
  static final FirebaseAuthRepository authRepository =
      FirebaseAuthRepository.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final UsersRepository usersRepository = UsersRepository.instance;

  static final ProductsRepository productsRepository =
      ProductsRepository.instance;

  static final CategoriesRepository categoriesRepository =
      CategoriesRepository.instance;

  static final CartsRepository cartsRepository = CartsRepository.instance;

  static final ShippingAddressRepository shippingAdressRepository =
      ShippingAddressRepository.instance;

  static final FavoritesRepository favoritesRepository =
      FavoritesRepository.instance;

  static final CardsRepository cardsRepository = CardsRepository.instance;

  static final OrdersRepository ordersRepository = OrdersRepository.instance;
}
