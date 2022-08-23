import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard(
    this.cartProduct, {
    Key? key,
  }) : super(key: key);
  final CartProductModel cartProduct;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .17,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        direction: Axis.horizontal,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 20,
            child: CachedNetworkImage(
                imageUrl: cartProduct.image,
                // imageUrl: "https://i.ibb.co/zmty86W/Mockup3.png",
                fit: BoxFit.fill,
                placeholder: (_, __) => const ShimmerWidget()),
          ),
          const GapW(20),
          Flexible(
            fit: FlexFit.tight,
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartProduct.name,
                    style: Get.textTheme.headline4,
                  ),
                  const GapH(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Quantity: ",
                            style: Get.textTheme.bodyText1!.copyWith(height: 0),
                          ),
                          Text(
                            "${cartProduct.quantity}",
                            style: Get.textTheme.headline5,
                          ),
                        ],
                      ),
                      Text(
                        "\$${cartProduct.price}",
                        style: Get.textTheme.headline4!
                            .copyWith(color: Get.theme.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
