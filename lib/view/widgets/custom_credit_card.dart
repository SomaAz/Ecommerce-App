import 'package:awesome_card/awesome_card.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:flutter/material.dart';

class CustomCreditCard extends StatelessWidget {
  const CustomCreditCard(
    this.card, {
    Key? key,
    this.showBackSide = false,
  }) : super(key: key);

  final CardModel card;
  final bool showBackSide;

  @override
  Widget build(BuildContext context) {
    return CreditCard(
      cardNumber: AppFunctions.splitCardNumber(card.number),
      // cardNumber: card.number,
      cardExpiry: card.expiryDate,
      cardHolderName: card.holder,
      cvv: card.cvv,
      // bankName: "Axis Bank",
      // cardType:
      //     CardType.master, // Optional if you want to override Card Type
      showBackSide: showBackSide,
      frontBackground: CardBackgrounds.black,
      backBackground: CardBackgrounds.white,
      showShadow: false,
      textExpDate: 'Exp. Date',
      textName: 'Name',
      textExpiry: 'MM/YY',
    );
  }
}
