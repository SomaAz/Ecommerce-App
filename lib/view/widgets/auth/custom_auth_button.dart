import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAuthButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CustomAuthButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // color: AppColors.primaryColor,
      color: Get.theme.primaryColor,
      textColor: Colors.white,
      onPressed: onPressed,
      elevation: 0,
      child: Text(text),
    );
  }
}
