import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  UserModel? userModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> getCurrentUserModel() async {
    userModel = await usersRepository.getCurrentUserModel();
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getCurrentUserModel();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await getCurrentUserModel();
    update();
  }

  @override
  void onReady() async {
    await loadData();
    super.onReady();
  }
}
