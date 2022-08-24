import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/user_model.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> getCurrentUserModel() async {
    _userModel = await AppRepositories.usersRepository.getCurrentUserModel();
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
  void onInit() async {
    await loadData();
    super.onInit();
  }
}
