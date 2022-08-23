import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      height: Get.height * .2,
      width: double.infinity,
      borderRadius: 6,
    );
  }
}
