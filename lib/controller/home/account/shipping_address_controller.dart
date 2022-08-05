import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  List<ShippingAddressModel> addresses = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  late ShippingAddressModel _selectedAddress;
  ShippingAddressModel get selectedAddress => _selectedAddress;

  void setSelectedAddress(ShippingAddressModel? value) {
    if (value != null) {
      _selectedAddress = value;
      update();
    }
  }

  Future<void> getCurrentUserShippingAddresses() async {
    addresses =
        await shippingAdressRepository.getCurrentUserShippingAddresses();
    if (addresses.isNotEmpty) _selectedAddress = addresses[0];
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getCurrentUserShippingAddresses();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await getCurrentUserShippingAddresses();
    update();
  }

  @override
  void onReady() async {
    await loadData();
    if (Get.previousRoute == AppRoutes.checkout) {
      _selectedAddress =
          addresses.firstWhere((address) => address.id == Get.arguments['id']);
    }
    super.onReady();
  }
}
