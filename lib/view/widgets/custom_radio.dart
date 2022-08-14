import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final void Function(T value)? onChanged;
  final String? text;
  const CustomRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconButton = IconButton(
      onPressed: () => onChanged?.call(value),
      icon: Icon(
        value == groupValue ? Icons.check_circle : Icons.circle,
        color:
            value == groupValue ? Get.theme.primaryColor : Colors.grey.shade300,
        size: 26,
      ),
    );
    return text != null
        ? Row(
            children: [
              iconButton,
              Text(
                text!,
                style: Get.textTheme.headline6,
              ),
            ],
          )
        : iconButton;
  }
}
