import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInService._();
  static Future<UserCredential?> loginWithGoogle() async {
    try {
      final account = await googleSignIn.signIn();
      if (account != null) {
        final authentication = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );

        final authResult = await authRepository.loginWithCredential(credential);

        final username = authResult.user!.displayName!;
        final email = authResult.user!.email!;

        UserModel userModel = UserModel(
          id: authResult.user!.uid,
          username: username,
          email: email,
          image: "",
        );

        await usersRepository.addUserToFirestore(userModel).onError(
          (error, stackTrace) {
            deleteUser();
          },
        );

        return authResult;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // AppFunctions.handleAuthException(e.code);

      return Future.error(e.message ?? e);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

  static Future<void> deleteUser() async {
    User? user = FirebaseAuthRepository.firebaseAuth.currentUser;
    if (user != null) {
      await user.delete();
      await authRepository.signOut();
    }
  }
}
