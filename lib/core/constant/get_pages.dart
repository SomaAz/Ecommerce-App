import 'package:ecommerce_getx/controller/home/account/cards_controller.dart';
import 'package:ecommerce_getx/controller/home/account/new_card_controller.dart';
import 'package:ecommerce_getx/controller/home/account/new_shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/home/account/order_details_controller.dart';
import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/category_details_controller.dart';
import 'package:ecommerce_getx/controller/home/cart/checkout/checkout_controller.dart';
import 'package:ecommerce_getx/controller/home/explore/search_controller.dart';
import 'package:ecommerce_getx/controller/product_details_controller.dart';
import 'package:ecommerce_getx/controller/auth/forgot_password_controller.dart';
import 'package:ecommerce_getx/controller/auth/login_controller.dart';
import 'package:ecommerce_getx/controller/auth/register_controller.dart';
import 'package:ecommerce_getx/view/screens/home/account/cards/cards.dart';
import 'package:ecommerce_getx/view/screens/home/account/cards/new_card.dart';
import 'package:ecommerce_getx/view/screens/home/account/orders/order_details.dart';
import 'package:ecommerce_getx/view/screens/home/account/orders/orders.dart';
import 'package:ecommerce_getx/view/screens/home/account/shipping/new_shipping_address.dart';
import 'package:ecommerce_getx/view/screens/home/account/shipping/shipping_address.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/screens/home/cart/checkout/checkout.dart';
import 'package:ecommerce_getx/view/screens/home/explore/search.dart';
import 'package:ecommerce_getx/view/screens/product_details.dart';
import 'package:ecommerce_getx/view/screens/auth/forgot_password.dart';
import 'package:ecommerce_getx/view/screens/auth/login.dart';
import 'package:ecommerce_getx/view/screens/auth/register.dart';
import 'package:ecommerce_getx/view/screens/home/home.dart';
import 'package:ecommerce_getx/view/screens/splash.dart';

import 'package:ecommerce_getx/core/middleware/auth_middleware.dart';
import 'package:ecommerce_getx/core/bindings/home_bindings.dart';

import 'package:get/get.dart';

class AppRoutes {
  static const splash = "/";
  //?Home
  static const home = "/home";
  static const search = "/search";
  //?Cart
  // static const cart = "/cart";
  static const checkout = "/checkout";
  //?Auth
  static const register = "/register";
  static const login = "/login";
  static const forgotPassword = "/forgot-password";
  //?Details Screens
  static const categoryDetails = "/category-details";
  static const productDetails = "/product-details";
  static const orderDetails = "/order-details";
  //?Account
  static const shippingAddress = '/shipping-address';
  static const newShippingAddress = '/new-shipping-address';
  static const cards = '/cards';
  static const newCard = '/new-card';
  static const orders = '/orders';

  const AppRoutes._();

  static final List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      middlewares: [AuthMiddleWare()],
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      // binding: BindingsBuilder.put(() => HomeController()),
      binding: HomeBindings(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: BindingsBuilder.put(() => RegisterController()),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder.put(() => ForgotPasswordController()),
    ),
    GetPage(
      name: categoryDetails,
      page: () => const CategoryDetailsScreen(),
      binding: BindingsBuilder.put(() => CategoryDetailsController()),
    ),
    GetPage(
      name: search,
      page: () => const SearchScreen(),
      binding: BindingsBuilder.put(() => SearchController()),
    ),
    GetPage(
      name: productDetails,
      page: () => const ProductDetailsScreen(),
      binding: BindingsBuilder.put(() => ProductDetailsController()),
    ),
    GetPage(
      name: shippingAddress,
      page: () => const ShippingAddressScreen(),
      binding: BindingsBuilder.put(() => ShippingAddressController()),
    ),
    GetPage(
      name: newShippingAddress,
      page: () => const NewShippingAddressScreen(),
      binding: BindingsBuilder.put(() => NewShippingAddressController()),
    ),
    GetPage(
      name: checkout,
      page: () => const CheckoutScreen(),
      binding: BindingsBuilder.put(() => CheckoutController()),
    ),
    GetPage(
      name: cards,
      page: () => const CardsScreen(),
      binding: BindingsBuilder.put(() => CardsController()),
    ),
    GetPage(
      name: newCard,
      page: () => const NewCardScreen(),
      binding: BindingsBuilder.put(() => NewCardController()),
    ),
    GetPage(
      name: orders,
      page: () => const OrdersScreen(),
      binding: BindingsBuilder.put(() => OrdersController()),
    ),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetailsScreen(),
      binding: BindingsBuilder.put(() => OrderDetailsController()),
    ),
    // GetPage(
    //   name: cart,
    //   page: () => const CartScreen(),
    //   binding: BindingsBuilder.put(() => CartController()),
    // ),
  ];
}
