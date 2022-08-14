import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsController extends GetxController {
  List<CardModel> cards = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  late CardModel? _selectedCard;
  CardModel? get selectedCard => _selectedCard;

  void setSelectedCard(CardModel value) {
    _selectedCard = value;
    update();
  }

  Future<void> getCurrentUsercards() async {
    cards = await cardsRepository.getCurrentUserCards();
    if (cards.isNotEmpty) _selectedCard = cards[0];
  }

  Future<void> deleteCard(CardModel card) async {
    await AppFunctions.showChoiceDialog(
      text: "Are Sure You Wan't To Delete This Payment Card?",
      onConfirm: () async {
        await _deleteCard(card).then((value) => Get.back());
      },
    );
  }

  Future<void> _deleteCard(CardModel card) async {
    await cardsRepository.deleteCard(card).then((value) {
      //?check if the selected card equals the deleted card
      if (_selectedCard == card) {
        final cardIndex = cards.indexOf(card);
        //?if there is any other card make it the selected card
        //?if there is no other card make the selected card null
        if (cards.length > cardIndex + 1) {
          _selectedCard = cards[cardIndex + 1];
        } else {
          _selectedCard = null;
        }
      }
      cards.remove(card);
      update();
    });
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await getCurrentUsercards();
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await getCurrentUsercards();
    update();
  }

  @override
  void onInit() async {
    await loadData();
    if (Get.arguments?['fromCheckout'] != null &&
        Get.arguments?['id'] != null) {
      _selectedCard = cards.firstWhere(
        (card) => card.id == Get.arguments?['id'],
      );
    }

    super.onInit();
  }
}
