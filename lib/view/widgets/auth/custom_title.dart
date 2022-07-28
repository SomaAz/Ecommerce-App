import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAuthTitleText extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomAuthTitleText(this.text1, this.text2, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          textAlign: TextAlign.center,
          style: Get.textTheme.headline2,
        ),
        const GapH(6),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyText1,
        ),
      ],
    );
  }
}
