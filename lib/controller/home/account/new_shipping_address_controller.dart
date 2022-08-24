import 'package:ecommerce_getx/controller/home/account/shipping_address_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewShippingAddressController extends GetxController {
  final nameController = TextEditingController();
  final fullNameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final streetController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> addAddress() async {
    if (formKey.currentState!.validate()) {
      setIsLoading(true);
      await _addAddress();
      await Get.find<ShippingAddressController>().refreshData();
      Get.back();
      setIsLoading(false);
    }
  }

  Future<void> _addAddress() async {
    final addressModel = ShippingAddressModel(
      id: "",
      name: nameController.text,
      userFullName: fullNameController.text,
      country: countryController.text,
      state: stateController.text,
      city: cityController.text,
      street: streetController.text,
    );

    await AppRepositories.shippingAdressRepository
        .addShippingAddress(addressModel);
  }
}
