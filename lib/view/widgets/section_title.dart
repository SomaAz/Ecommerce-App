import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
    this.text, {
    Key? key,
  })  : _widget = null,
        super(key: key);

  final String text;

  final Widget? _widget;

  const SectionTitle.withWidget(
    this.text,
    this._widget, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
