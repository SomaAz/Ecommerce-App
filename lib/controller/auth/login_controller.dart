import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey();
  final RxBool isShowPassword = false.obs;
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    setIsLoading(true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (AppFunctions.validateAndSaveForm(formKey)) {
      User? user;

      user = await authService.login(email, password).then((value) {
        setIsLoading(false);
        return value;
      }).catchError((error, stackTrace) {
        setIsLoading(false);
      });

      if (user != null) {
        Get.offNamed(AppRoutes.home);
      }
    }

    setIsLoading(false);
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
  }
}
