import 'dart:convert';

import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:ecommerce_getx/data/service/api/api_service_base.dart';

abstract class AuthServiceBase {
  Future<UserModel> login(String email, String password);

  Future<UserModel> register(String username, String email, String password);

  Future<void> logout();

  Future<void> sendResetPasswordEmail();
}

class AuthService extends AuthServiceBase {
  @override
  Future<UserModel> login(String email, String password) async {
    final response = await ApiService.post(
      "login",
      body: {
        "email": email,
        "password": password,
      },
    );

    final jsonData = response.body;
    final mapData = jsonDecode(jsonData);

    final user = UserModel.fromJson(mapData['user']);

    return user;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<UserModel> register(
      String username, String email, String password) async {
    final response = await ApiService.post(
      "register",
      body: {
        "username": username,
        "email": email,
        "password": password,
      },
    );

    final jsonData = response.body;
    final mapData = jsonDecode(jsonData);

    final user = UserModel.fromJson(mapData['user']);

    return user;
  }

  @override
  Future<void> sendResetPasswordEmail() async {}
}
