import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/controller/auth/auth_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';

class AuthMiddleWare extends GetMiddleware {
  AuthController authController = Get.put(AuthController());

  // @override
  // List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
  //   authController = Get.find();
  //   return super.onBindingsStart(bindings);
  // }

  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuthRepository.firebaseAuth.currentUser != null) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return const RouteSettings(name: AppRoutes.login);
  }
}
