import 'package:ecommerce_getx/controller/home/account/new_card_controller.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_textformfield.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewCardScreen extends StatelessWidget {
  const NewCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSliverLayout(
        title: "New Card",
        children: [
          GetBuilder<NewCardController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  children: [
                    CustomTextFormField(
                      labelText: "Card Number",
                      // hintText: "0000 0000 0000 0000",
                      hintText: "XXXX XXXX XXXX XXXX",
                      controller: controller.numberController,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 16 + 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberFormatter(),
                      ],

                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          if (int.tryParse(val.replaceAll(" ", "")) == null) {
                            return "Not Valid Card Number";
                          }
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    CustomTextFormField(
                      labelText: "Card Holder",
                      hintText: "John Rock",
                      controller: controller.holderController,
                      maxLines: 1,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          final validation = AppFunctions.validateField(
                            val,
                            min: 4,
                            max: 26,
                          );
                          return validation;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          child: CustomTextFormField(
                            labelText: "Exp. Date",
                            hintText: "MM/YY",
                            controller: controller.expiryDateController,
                            maxLength: 5,
                            maxLines: 1,
                            padding: const EdgeInsets.only(
                              bottom: 20,
                              top: 20,
                              left: 30,
                            ),
                            validator: (val) {
                              if (val != null && val.trim().isNotEmpty) {
                                val = val.trim();
                                // if (DateTime.tryParse(val) == null) {
                                //   return "Not Valid ExpDate";
                                // }
                                // print(DateFormat("MM/YY").parse(val));
                                try {
                                  DateFormat("MM/yy").parse(val);
                                  return null;
                                } on FormatException {
                                  return "Not Valid ExpDate";
                                }
                              }
                              return "Not Valid ExpDate";
                            },
                          ),
                        ),
                        GapW(Get.width * .15),
                        Flexible(
                          child: CustomTextFormField(
                            labelText: "CVV",
                            hintText: "000",
                            controller: controller.cvvController,
                            maxLength: 3,
                            maxLines: 1,
                            padding: const EdgeInsets.only(
                              bottom: 20,
                              top: 20,
                              left: 30,
                            ),
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            validator: (val) {
                              if (val != null && val.trim().isNotEmpty) {
                                val = val.trim();
                                if (int.tryParse(val) == null) {
                                  return "Not Valid CVV";
                                }
                                return null;
                              }

                              return "Not Valid CVV";
                            },
                          ),
                        ),
                      ],
                    ),
                    const GapH(30),
                    controller.isLoading
                        ? const Loading()
                        : CustomButton(
                            text: "Add",
                            onPressed: () {
                              controller.addCard();
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
