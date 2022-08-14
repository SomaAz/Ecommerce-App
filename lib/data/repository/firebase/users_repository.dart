import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UsersRepositoryBase {
  Future<void> addUserToFirestore(UserModel userModel);
  Future<UserModel> getUserModel(String uid);
  Future<UserModel> getCurrentUserModel();
  Future<void> changeUsername(String newUsername);
}

class UsersRepository extends UsersRepositoryBase {
  static final UsersRepository instance = UsersRepository._();
  UsersRepository._();

  static final _usersCollection = firestore.collection("users");

  @override
  Future<void> addUserToFirestore(UserModel userModel) async {
    final userDoc = _usersCollection.doc(userModel.id);

    try {
      await userDoc.set({...userModel.toMap(), "currentOrderNumber": 0});
    } catch (e) {
      userDoc.delete();

      throw FirebaseAuthException(code: "");
    }
  }

  @override
  Future<UserModel> getUserModel(String uid) async {
    final snapshot = await _usersCollection.doc(uid).get();
    final userModel = UserModel.fromMap(snapshot.data()!);
    return userModel;
  }

  @override
  Future<UserModel> getCurrentUserModel() async {
    final uid = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;
    return await getUserModel(uid);
  }

  @override
  Future<void> changeUsername(String newUsername) async {
    final uid = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;
    final docRef = _usersCollection.doc(uid);

    await docRef.update({"username": newUsername});
  }
}
