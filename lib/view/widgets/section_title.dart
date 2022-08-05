import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
    this.text, {
    Key? key,
    this.withPadding = true,
  })  : _widget = null,
        super(key: key);

  final String text;
  final bool withPadding;
  final Widget? _widget;

  const SectionTitle.withWidget(
    this.text,
    this._widget, {
    Key? key,
    this.withPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: withPadding
          ? const EdgeInsets.symmetric(horizontal: 20.0)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Get.textTheme.headline3,
          ),
          if (_widget != null) _widget!,
        ],
      ),
    );
  }
}
