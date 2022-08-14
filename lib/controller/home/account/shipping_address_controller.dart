import 'dart:developer';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  List<ShippingAddressModel> addresses = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  ShippingAddressModel? _selectedAddress;
  ShippingAddressModel? get selectedAddress => _selectedAddress;

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

  Future<void> deleteShippingAddress(ShippingAddressModel address) async {
    AppFunctions.showChoiceDialog(
      text: "Are You Sure you Want To Delete This Shipping Address?",
      onConfirm: () async {
        log('hello');
        await _deleteShippingAddress(address).then((value) => Get.back());
      },
    );
  }

  Future<void> _deleteShippingAddress(ShippingAddressModel address) async {
    await shippingAdressRepository.deleteShippingAddress(address).then((value) {
      //?check if the selected address equals the deleted address
      if (_selectedAddress == address) {
        final addressIndex = addresses.indexOf(address);
        //?if there is any other address make it the selected address
        //?if there is no other address make the selected address null
        if (addresses.length > addressIndex + 1) {
          _selectedAddress = addresses[addressIndex + 1];
        } else {
          _selectedAddress = null;
        }
      }
      addresses.remove(address);
      update();
    });
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
  void onInit() async {
    await loadData();
    if (Get.arguments?['fromCheckout'] != null && Get.arguments['id'] != null) {
      _selectedAddress =
          addresses.firstWhere((address) => address.id == Get.arguments['id']);
    }
    super.onInit();
  }
}
