import 'package:ecommerce_getx/controller/home/account/cards_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditCardController extends GetxController {
  late final TextEditingController numberController;
  late final TextEditingController expiryDateController;
  late final TextEditingController holderController;
  late final TextEditingController cvvController;

  final formKey = GlobalKey<FormState>();

  late final CardModel card;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> editCard() async {
    if (formKey.currentState!.validate()) {
      setIsLoading(true);

      final newCard = CardModel(
        id: card.id,
        number: numberController.text,
        expiryDate: expiryDateController.text,
        holder: holderController.text,
        cvv: cvvController.text,
      );

      final haveEdits = newCard != card;

      if (haveEdits) {
        await AppRepositories.cardsRepository.editCard(newCard);
        await Get.find<CardsController>().refreshData();
      }

      Get.back();
      setIsLoading(false);
    }
  }

  @override
  void onInit() {
    card = Get.arguments['card'];

    numberController = TextEditingController(text: card.number);
    expiryDateController = TextEditingController(text: card.expiryDate);
    holderController = TextEditingController(text: card.holder);
    cvvController = TextEditingController(text: card.cvv);

    super.onInit();
  }
}
