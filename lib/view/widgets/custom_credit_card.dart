import 'package:awesome_card/awesome_card.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/view/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

class CustomCreditCard extends StatelessWidget {
  CustomCreditCard(
    this.card, {
    Key? key,
    this.showBackSide = false,
    this.onDelete,
    this.onEdit,
    this.haveActions = true,
    this.hideNumber = false,
  })  : selectedCard = null,
        onChanged = null,
        _widgetKey = GlobalKey(),
        super(key: key);

  final GlobalKey _widgetKey;

  final CardModel? selectedCard;
  final void Function(CardModel)? onChanged;
  CustomCreditCard.radio(
    this.card, {
    Key? key,
    this.showBackSide = false,
    this.onDelete,
    this.onEdit,
    this.haveActions = true,
    this.hideNumber = false,
    required this.selectedCard,
    required this.onChanged,
  })  : _widgetKey = GlobalKey(),
        super(key: key);

  final CardModel card;
  final bool showBackSide;
  final void Function(CardModel card)? onDelete;
  final void Function(CardModel card)? onEdit;
  final bool haveActions;
  final bool hideNumber;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        key: _widgetKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (haveActions) {
                AppFunctions.showPopupMenu(
                  context: context,
                  widgetKey: _widgetKey,
                  onSelected: (value) {
                    switch (value) {
                      case "Delete":
                        onDelete?.call(card);
                        break;
                      case "Edit":
                        onEdit?.call(card);
                        break;
                      default:
                        return;
                    }
                  },
                );
              }
            },
            child: CreditCard(
              cardNumber: hideNumber
                  ? AppFunctions.splitAndHideCardNumber(card.number)
                  : AppFunctions.splitCardNumber(card.number),
              cardExpiry: card.expiryDate,
              cardHolderName: card.holder,
              cvv: card.cvv,
              showBackSide: showBackSide,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: false,
              textExpDate: 'Exp. Date',
              textName: 'Name',
              textExpiry: 'MM/YY',
            ),
          ),
          if (onChanged != null)
            CustomRadio<CardModel>(
              value: card,
              groupValue: selectedCard,
              onChanged: onChanged,
              text: "Selected",
              // activeColor: Get.theme.primaryColor,
            ),
        ],
      );
    });
  }
}
