import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditShippingAddressController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController fullNameController;
  late final TextEditingController countryController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController streetController;

  final formKey = GlobalKey<FormState>();

  late final ShippingAddressModel shippingAddress;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> editAddress() async {
    if (formKey.currentState!.validate()) {
      setIsLoading(true);

      final newAddressModel = ShippingAddressModel(
        id: shippingAddress.id.trim(),
        name: nameController.text,
        userFullName: fullNameController.text,
        country: countryController.text,
        state: stateController.text,
        city: cityController.text,
        street: streetController.text,
      );

      final haveEdits = newAddressModel != shippingAddress;

      if (haveEdits) {
        await shippingAdressRepository.editShippingAddress(newAddressModel);
        await Get.find<ShippingAddressController>().refreshData();
      }

      Get.back();
      setIsLoading(false);
    }
  }

  @override
  void onInit() {
    shippingAddress = Get.arguments;

    nameController = TextEditingController(text: shippingAddress.name);
    fullNameController =
        TextEditingController(text: shippingAddress.userFullName);
    countryController = TextEditingController(text: shippingAddress.country);
    cityController = TextEditingController(text: shippingAddress.city);
    stateController = TextEditingController(text: shippingAddress.state);
    streetController = TextEditingController(text: shippingAddress.street);

    super.onInit();
  }
}
