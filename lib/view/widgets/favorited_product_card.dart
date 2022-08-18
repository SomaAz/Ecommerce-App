import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritedProductCard extends StatelessWidget {
  const FavoritedProductCard(
    this.product, {
    required this.onDelete,
    Key? key,
  }) : super(key: key);
  final ProductModel product;
  final void Function() onDelete;

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
              imageUrl: product.image,
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
                        product.name,
                        style: Get.textTheme.headline4,
                      ),
                      const GapH(2),
                      Text(
                        "\$${product.price}",
                        style: Get.textTheme.headline4!
                            .copyWith(color: Get.theme.primaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
