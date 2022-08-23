import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutlinedCustomButton extends StatelessWidget {
  const OutlinedCustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.color,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      textColor: color ?? Get.theme.primaryColor,
      // textColor: Colors.black,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: Get.width * .15,
            vertical: 15,
          ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: color ?? Get.theme.primaryColor,
          // color: Colors.black,
        ),
      ),
      child: Text(text),
    );
  }
}
