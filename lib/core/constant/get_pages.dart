import 'package:ecommerce_getx/controller/auth/change_password_controller.dart';
import 'package:ecommerce_getx/controller/home/account/cards_controller.dart';
import 'package:ecommerce_getx/controller/home/account/edit_card_controller.dart';
import 'package:ecommerce_getx/controller/home/account/edit_profile_controller.dart';
import 'package:ecommerce_getx/controller/home/account/edit_shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/home/account/new_card_controller.dart';
import 'package:ecommerce_getx/controller/home/account/new_shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/home/account/order_details_controller.dart';
import 'package:ecommerce_getx/controller/home/account/orders_controller.dart';
import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/controller/category_details_controller.dart';
import 'package:ecommerce_getx/controller/home/account/track_order_controller.dart';
import 'package:ecommerce_getx/controller/home/cart/checkout/checkout_controller.dart';
import 'package:ecommerce_getx/controller/home/explore/search_controller.dart';
import 'package:ecommerce_getx/controller/product_details_controller.dart';
import 'package:ecommerce_getx/controller/auth/forgot_password_controller.dart';
import 'package:ecommerce_getx/controller/auth/login_controller.dart';
import 'package:ecommerce_getx/controller/auth/register_controller.dart';
import 'package:ecommerce_getx/view/screens/auth/change_password.dart';
import 'package:ecommerce_getx/view/screens/home/account/cards/cards.dart';
import 'package:ecommerce_getx/view/screens/home/account/cards/edit_card.dart';
import 'package:ecommerce_getx/view/screens/home/account/cards/new_card.dart';
import 'package:ecommerce_getx/view/screens/home/account/edit_profile/edit_profile.dart';
import 'package:ecommerce_getx/view/screens/home/account/orders/order_details.dart';
import 'package:ecommerce_getx/view/screens/home/account/orders/orders.dart';
import 'package:ecommerce_getx/view/screens/home/account/orders/track_order.dart';
import 'package:ecommerce_getx/view/screens/home/account/shipping/edit_shipping_address.dart';
import 'package:ecommerce_getx/view/screens/home/account/shipping/new_shipping_address.dart';
import 'package:ecommerce_getx/view/screens/home/account/shipping/shipping_address.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/screens/home/cart/checkout/checkout.dart';
import 'package:ecommerce_getx/view/screens/home/explore/best_selling.dart';
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
  static const bestSelling = "/best-selling";
  //?Cart
  // static const cart = "/cart";
  static const checkout = "/checkout";
  //?Auth
  static const register = "/register";
  static const login = "/login";
  static const forgotPassword = "/forgot-password";
  static const changePassword = "/change-password";
  //?Details Screens
  static const categoryDetails = "/category-details";
  static const productDetails = "/product-details";
  static const orderDetails = "/order-details";
  //?Account
  static const shippingAddress = '/shipping-address';
  static const newShippingAddress = '/new-shipping-address';
  static const editShippingAddress = '/edit-shipping-address';
  static const cards = '/cards';
  static const newCard = '/new-card';
  static const editCard = '/edit-card';
  static const orders = '/orders';
  static const trackOrder = '/track-order';
  static const editProfile = '/edit-profile';

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
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
      transition: Transition.rightToLeft,
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
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      binding: BindingsBuilder.put(() => EditProfileController()),
    ),
    GetPage(
      name: trackOrder,
      page: () => const TrackOrderScreen(),
      binding: BindingsBuilder.put(() => TrackOrderController()),
    ),
    GetPage(
      name: editShippingAddress,
      page: () => const EditShippingAddressScreen(),
      binding: BindingsBuilder.put(() => EditShippingAddressController()),
    ),
    GetPage(
      name: editCard,
      page: () => const EditCardScreen(),
      binding: BindingsBuilder.put(() => EditCardController()),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      binding: BindingsBuilder.put(() => ChangePasswordController()),
    ),
    GetPage(
      name: bestSelling,
      page: () => const BestSellingScreen(),
      //?No Need For Controller Here Because It's Initialized At (ExploreScreen)
      // binding: BindingsBuilder.put(() => BestSellingController()),
    ),
  ];
}
