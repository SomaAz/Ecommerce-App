import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function()? onTapIcon;
  final int? maxLength;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.icon,
    required this.hintText,
    this.controller,
    // required
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.onTapIcon,
    this.maxLength,
    this.maxLines,
    this.padding,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChange,
      decoration: InputDecoration(
        contentPadding:
            padding ?? const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(labelText),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16),
        suffixIcon: icon == null
            ? const SizedBox()
            : onTapIcon == null
                ? Icon(icon)
                : IconButton(icon: Icon(icon), onPressed: onTapIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        counterText: "",
      ),
    );
  }
}
