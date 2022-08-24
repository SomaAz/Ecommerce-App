import 'package:ecommerce_getx/controller/home/account/account_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  late final UserModel userModel;
  late final TextEditingController usernameController;

  final GlobalKey<FormState> formKey = GlobalKey();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> saveChanges() async {
    if (formKey.currentState!.validate()) {
      setIsLoading(true);

      final newUsername = usernameController.text.trim();
      if (userModel.username != newUsername) {
        await AppRepositories.usersRepository
            .changeUsername(newUsername)
            .then((value) async {
          await Get.find<AccountController>().refreshData();
          Get.snackbar("", "Changes Saved Successfully");
        });
      }
    }
    setIsLoading(false);
  }

  @override
  void onInit() {
    userModel = Get.arguments?['userModel'];
    usernameController = TextEditingController(text: userModel.username);
    super.onInit();
  }
}
