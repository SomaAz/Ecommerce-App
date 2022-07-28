import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    this.hint,
    this.controller,
    this.onTap,
    this.icon,
    this.autofocus = false,
    this.enableInteractiveSelection,
    this.enabled,
    this.readOnly = false,
    this.onChanged,
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final Widget? icon;
  final bool autofocus;
  final bool? enableInteractiveSelection;
  final bool? enabled;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      enableInteractiveSelection: enableInteractiveSelection,
      enabled: enabled,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16),
        prefixIcon: icon ?? const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),

        // border: InputBorder.none.copyWith(),
        // border: ,
        // fillColor: Colors.black54,
        filled: true,
      ),
    );
  }
}
