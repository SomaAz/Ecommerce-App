import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  final RxBool isLoading = false.obs;

  Future<void> sendResetPasswordEmail() async {
    setIsLoading(true);

    final email = emailController.text.trim();

    if (AppFunctions.validateAndSaveForm(formKey)) {
      await AppRepositories.authRepository
          .sendPasswordResetEmail(email)
          .then((value) {
        Get.back();
        Get.snackbar(
          "Notice",
          "A Password Reset Link Sent To $email",
          backgroundColor: Get.theme.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        setIsLoading(false);
      }).catchError((error, stackTrace) {
        setIsLoading(false);
      });
    }

    setIsLoading(false);
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
  }
}
