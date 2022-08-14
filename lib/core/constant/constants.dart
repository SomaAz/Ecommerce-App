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
import 'package:get/get.dart';

//? Repositories
final FirebaseAuthRepository authRepository = FirebaseAuthRepository.instance;

final FirebaseFirestore firestore = FirebaseFirestore.instance;

final UsersRepository usersRepository = UsersRepository.instance;

final ProductsRepository productsRepository = ProductsRepository.instance;

final CategoriesRepository categoriesRepository = CategoriesRepository.instance;

final CartsRepository cartsRepository = CartsRepository.instance;

final ShippingAddressRepository shippingAdressRepository =
    ShippingAddressRepository.instance;

final FavoritesRepository favoritesRepository = FavoritesRepository.instance;

final CardsRepository cardsRepository = CardsRepository.instance;

final OrdersRepository ordersRepository = OrdersRepository.instance;
//?
//?
//?
double get productCardHeight => (Get.height * .3);

final remainingScreenHeight =
    Get.height - Get.height * .13 - Get.statusBarHeight;
