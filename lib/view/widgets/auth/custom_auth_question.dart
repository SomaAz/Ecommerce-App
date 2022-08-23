import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAuthQuestion extends StatelessWidget {
  final String text;
  final String buttonText;
  final void Function() onPressed;
  const CustomAuthQuestion({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 15),
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: " $buttonText",
            style: TextStyle(
              color: Get.theme.primaryColor,
              // fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}
