import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCenteredText extends StatelessWidget {
  const CustomCenteredText(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Get.textTheme.headline5,
      ),
    );
  }
}
