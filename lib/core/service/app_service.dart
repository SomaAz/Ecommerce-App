import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppServices extends GetxService {
  // late SharedPreferences sharedPrefs;

  Future<AppServices> init() async {
    // sharedPrefs = await SharedPreferences.getInstance();
    return this;
  }
}
