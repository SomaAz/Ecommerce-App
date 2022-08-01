import 'package:ecommerce_getx/controller/home/account/new_shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/category_details_controller.dart';
import 'package:ecommerce_getx/controller/home/cart/checkout/checkout_controller.dart';
import 'package:ecommerce_getx/controller/home/explore/search_controller.dart';
import 'package:ecommerce_getx/controller/product_details_controller.dart';
import 'package:ecommerce_getx/controller/auth/forgot_password_controller.dart';
import 'package:ecommerce_getx/controller/auth/login_controller.dart';
import 'package:ecommerce_getx/controller/auth/register_controller.dart';
import 'package:ecommerce_getx/view/screens/home/account/new_shipping_address.dart';
import 'package:ecommerce_getx/view/screens/home/account/shipping_address.dart';
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
  //?Account
  static const shippingAddress = '/shipping-address';
  static const newShippingAddress = '/new-shipping-address';

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
      page: () => CheckoutScreen(),
      binding: BindingsBuilder.put(() => CheckoutController()),
    ),
    // GetPage(
    //   name: cart,
    //   page: () => const CartScreen(),
    //   binding: BindingsBuilder.put(() => CartController()),
    // ),
  ];
}
