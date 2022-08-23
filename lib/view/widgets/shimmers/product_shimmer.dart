import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .45,
      child: Flex(
        direction: Axis.vertical,
        children: [
          const Flexible(
            flex: 2,
            child: ShimmerWidget(borderRadius: 5),
          ),
          const GapH(12),
          // const GapH(12),
          Flexible(
            child: Column(
              children: const [
                Expanded(child: ShimmerWidget()),
                GapH(12),
                Expanded(child: ShimmerWidget()),
                GapH(12),
                Expanded(child: ShimmerWidget()),
                GapH(12),
                GapH(12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
