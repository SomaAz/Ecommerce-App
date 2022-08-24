import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  final RxBool isShowPassword = false.obs;
  final RxBool isShowConfirmPassword = false.obs;
  final RxBool isLoading = false.obs;

  Future<void> register() async {
    isLoading.value = true;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final username = usernameController.text.trim();
    // isLoading.value = false;

    if (AppFunctions.validateAndSaveForm(formKey)) {
      final user = await AppRepositories.authRepository
          .register(email, password, username)
          .then((value) {
        setIsLoading(false);
        return value;
      }).catchError((error, stackTrace) {
        setIsLoading(false);
      });
      isLoading.value = false;

      if (user != null) {
        Get.offNamed(AppRoutes.home);
      }
    }
    isLoading.value = false;
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
  }
}
