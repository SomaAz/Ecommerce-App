import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAuthBodyText extends StatelessWidget {
  final String text;
  const CustomAuthBodyText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Get.textTheme.bodyText1,
    );
  }
}
