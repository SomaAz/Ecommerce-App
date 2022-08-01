import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';
import 'package:ecommerce_getx/data/repository/google_sign_in/google_sign_in_service.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';

class AuthController extends GetxController {
  late Rx<User?> user = Rx(null);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    user.bindStream(FirebaseAuthRepository.firebaseAuth.authStateChanges());
    ever(user, (_) => update());
    super.onInit();
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    if (user.value == null) {
      Get.offNamed(AppRoutes.login);
    }
  }

  Future<void> loginWithGoogle() async {
    Get.defaultDialog(
      title: "",
      content: Center(
        child: Column(
          children: const [
            Text("logging in with google"),
            GapH(10),
            Loading(),
          ],
        ),
      ),
    );
    final credential = await GoogleSignInService.loginWithGoogle();

    Get.back();
    if (credential != null) {
      if (credential.user != null) {
        Get.offNamed(AppRoutes.home);
      }
    }
  }
}
