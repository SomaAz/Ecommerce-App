import 'dart:developer';

import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:get/get.dart';

class CardsController extends GetxController {
  List<CardModel> cards = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  late CardModel _selectedCard;
  CardModel get selectedCard => _selectedCard;

  void setSelectedCard(CardModel value) {
    _selectedCard = value;
    update();
  }

  Future<void> getCurrentUsercards() async {
    cards = await cardsRepository.getCurrentUserCards();
    if (cards.isNotEmpty) _selectedCard = cards[0];
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
  void onReady() async {
    await loadData();
    if (Get.previousRoute == AppRoutes.checkout) {
      log(selectedCard.number);

      _selectedCard = cards.firstWhere(
        (card) => card.id == Get.arguments['id'],
      );

      // update();
      log(selectedCard.number);
    }

    super.onReady();
  }
}
