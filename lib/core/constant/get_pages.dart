import 'package:ecommerce_getx/controller/category_details_controller.dart';
import 'package:ecommerce_getx/controller/home/search_controller.dart';
import 'package:ecommerce_getx/controller/product_details_controller.dart';
import 'package:ecommerce_getx/controller/auth/forgot_password_controller.dart';
import 'package:ecommerce_getx/controller/auth/login_controller.dart';
import 'package:ecommerce_getx/controller/auth/register_controller.dart';
import 'package:ecommerce_getx/core/middleware/auth_middleware.dart';

import 'package:ecommerce_getx/core/bindings/home_bindings.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/screens/home/search.dart';
import 'package:ecommerce_getx/view/screens/product_details.dart';
import 'package:ecommerce_getx/view/screens/auth/forgot_password.dart';
import 'package:ecommerce_getx/view/screens/auth/login.dart';
import 'package:ecommerce_getx/view/screens/auth/register.dart';
import 'package:ecommerce_getx/view/screens/home/home.dart';
import 'package:ecommerce_getx/view/screens/splash.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = "/";
  static const home = "/home";
  static const search = "/search";
  //?Auth
  static const register = "/register";
  static const login = "/login";
  static const forgotPassword = "/forgot-password";
  //?Details Screens
  static const categoryDetails = "/category-details";
  static const productDetails = "/product-details";

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
  ];
}
