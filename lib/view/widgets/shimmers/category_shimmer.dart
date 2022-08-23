import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerWidget(
          width: Get.height * .09,
          height: Get.height * .09,
          shape: BoxShape.circle,
        ),
        const GapH(6),
        const Expanded(
          child: ShimmerWidget(
              // width: Get.height * .09,
              ),
        ),
      ],
    );
  }
}
