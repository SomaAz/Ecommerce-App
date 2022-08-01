import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';

// const String apiKey = "AIzaSyD5kS3982ha9BbQ3J7A-5g40T2Z_tuoxUw";

abstract class FirebaseAuthRepositoryBase {
  Future<User?> login(String email, String password);
  Future<User?> register(String email, String password, String username);
  Future<void> sendPasswordResetEmail(String email);
  Future<UserCredential> loginWithCredential(AuthCredential credential);
  Future<void> signOut();
  Future<void> deleteUser(String email, String password);
}

class FirebaseAuthRepository extends FirebaseAuthRepositoryBase {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final FirebaseAuthRepository instance = FirebaseAuthRepository._();

  FirebaseAuthRepository._();

  @override
  Future<User?> login(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      AppFunctions.handleAuthException(e.code);

      return Future.error(e.message!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

  @override
  Future<User?> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = credential.user;
      if (user != null) {
        user.updateDisplayName(username);

        UserModel userModel = UserModel(
          id: user.uid,
          username: username,
          email: email,
          image: "",
        );

        await usersRepository.addUserToFirestore(userModel).onError(
          (error, stackTrace) {
            deleteUser(email, password);
            user = null;
          },
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      AppFunctions.handleAuthException(e.code);
      return Future.error(e.message!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

  @override
  Future<UserCredential> loginWithCredential(
    AuthCredential credential,
  ) async {
    try {
      return await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      AppFunctions.handleAuthException(e.code);

      return Future.error(e.message!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      // final token = await firebaseAuth.verifyPasswordResetCode(code);
      // firebaseAuth.reset
      // final password = "";

      await firebaseAuth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: "https://ecommerce-b4b2a.firebaseapp.com/__/auth/action",
          handleCodeInApp: true,
        ),
      );

      // http.post(
      //   Uri.parse(
      //     "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$apiKey",
      //   ),
      //   body: {
      //     "idToken": token,
      //     "password": password,
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      AppFunctions.handleAuthException(
        e.code,
        isEmailVerification: true,
        email: email,
      );

      return Future.error(e.message!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> deleteUser(String email, String password) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      await user.delete();
      await signOut();
    }
  }
}

//? Change Password Endpoint
//https://identitytoolkit.googleapis.com/v1/accounts:update?key=[API_KEY]


//write email 
//send 