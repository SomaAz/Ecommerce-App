import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard(
    this.cartProduct, {
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
    Key? key,
  }) : super(key: key);

  final CartProductModel cartProduct;
  final void Function() onDelete;
  final void Function() onIncrement;
  final void Function() onDecrement;

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
              fit: BoxFit.fill,
              placeholder: (_, __) => const Loading(),
            ),
          ),
          const GapW(20),
          Flexible(
            fit: FlexFit.tight,
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.name,
                        style: Get.textTheme.headline4,
                      ),
                      const GapH(2),
                      Text(
                        "\$${cartProduct.price}",
                        style: Get.textTheme.headline4!
                            .copyWith(color: Get.theme.primaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FittedBox(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: onIncrement,
                                icon: const Icon(
                                  Icons.add_rounded,
                                ),
                              ),
                              GetBuilder<CartController>(
                                builder: (controller) {
                                  return Text(
                                    "${cartProduct.quantity}",
                                    style: Get.textTheme.headline4,
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: onDecrement,
                                icon: const Icon(
                                  Icons.remove_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline_rounded),
                        // color: Colors.red,
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
