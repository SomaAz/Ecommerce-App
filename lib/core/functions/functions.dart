import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/service/app_service.dart';

enum ValidatedInputType {
  email,
  username,
  other,
}

class AppFunctions {
  //? Initialize App Services
  static Future<void> initServices() async {
    await Get.putAsync(() => AppServices().init());
    //...
  }

  //? Validate Form
  static bool validateForm(GlobalKey<FormState> formKey) {
    final formState = formKey.currentState;

    if (formState != null) {
      return formState.validate();
    }

    return false;
  }

  //? Validate Form
  static bool validateAndSaveForm(GlobalKey<FormState> formKey) {
    final isValid = validateForm(formKey);
    final formState = formKey.currentState;

    if (formState != null) {
      formKey.currentState!.save();
    }

    return isValid;
  }

  //? Validate Form
  static String? validateField(
    String? value, {
    int? min,
    int? max,
    ValidatedInputType inputType = ValidatedInputType.other,
  }) {
    if (!(value != null && value.trim().isNotEmpty)) {
      return "Please Enter A Value In This Field";
    }
    value = value.trim();

    if (min != null && value.length < min) {
      return "This Value Length Can't Be Less Than $min Characters";
    }
    if (max != null && value.length > max) {
      return "This Value Length Can't Be More Than $max Characters";
    }

    if (inputType == ValidatedInputType.email) {
      if (!GetUtils.isEmail(value)) {
        return "Please Type A Valid Email";
      }
    }
    if (inputType == ValidatedInputType.username) {
      if (!GetUtils.isUsername(value)) {
        return "Please Type A Valid Username";
      }
    }

    return null;
  }

  //?Error Snackbar
  static void showErrorSnackBar(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        message,
        backgroundColor: Get.theme.errorColor,
        colorText: Colors.white,
      );
    }
  }

  static String firebaseAuthExceptionMessage(
    String errorCode, {
    bool isEmailVerification = false,
    String email = "",
  }) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";

      default:
        return isEmailVerification
            ? "Failed To Send Verification Code To $email"
            : "Login failed. Please try again.";
    }
  }

  static void handleAuthException(
    String errorCode, {
    bool isEmailVerification = false,
    String email = "",
  }) {
    AppFunctions.showErrorSnackBar(firebaseAuthExceptionMessage(
      errorCode,
      isEmailVerification: isEmailVerification,
      email: email,
    ));
  }
}