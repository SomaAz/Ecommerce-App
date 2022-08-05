import 'package:ecommerce_getx/controller/home/account/cards_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewCardController extends GetxController {
  final numberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final holderController = TextEditingController();
  final cvvController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> addCard() async {
    if (formKey.currentState!.validate()) {
      setIsLoading(true);
      await _addCard();
      await Get.find<CardsController>().refreshData();
      Get.back();
      setIsLoading(false);
    }
  }

  Future<void> _addCard() async {
    final cardModel = CardModel(
      id: "",
      number: numberController.text,
      expiryDate: expiryDateController.text,
      holder: holderController.text,
      cvv: cvvController.text,
    );

    await cardsRepository.addCard(cardModel);
  }
}
