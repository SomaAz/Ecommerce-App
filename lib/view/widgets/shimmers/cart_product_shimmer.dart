import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductShimmer extends StatelessWidget {
  const CartProductShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .17,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const Flexible(flex: 20, child: ShimmerWidget()),
          const GapW(20),
          Flexible(
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: const [
                      ShimmerWidget(
                        width: double.infinity,
                        height: 15,
                      ),
                      GapH(8),
                      ShimmerWidget(
                        width: double.infinity,
                        height: 15,
                      ),
                    ],
                  ),
                  const ShimmerWidget(
                    width: double.infinity,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
