import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_getx/controller/product_details_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    this.heroTagAddition = "",
    Key? key,
  }) : super(key: key);
  final ProductModel product;
  final String heroTagAddition;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.put(ProductDetailsController());
        // Get.to(
        //   AppRoutes.getPages
        //       .firstWhere(
        //         (element) => element.name == AppRoutes.productDetails,
        //       )
        //       .page,
        //   arguments: {"product": product},
        //   preventDuplicates: true,
        //   transition: Transition.zoom,
        // );
        Get.toNamed(AppRoutes.productDetails, arguments: {
          "product": product,
          "heroTagAddition": heroTagAddition,
        });
      },
      child: SizedBox(
        width: Get.width * .45,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: "image:$heroTagAddition:${product.id}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        // imageUrl: "https://i.ibb.co/zmty86W/Mockup3.png",
                        fit: BoxFit.fill,
                        placeholder: (_, __) =>
                            const ColoredBox(color: Colors.grey),
                      ),
                    ),
                  ),
                  TagsBuilder(product.tags),
                ],
              ),
            ),
            const GapH(4),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "name:$heroTagAddition:${product.id}",
                    child: Text(
                      product.name,
                      style: Get.textTheme.headline4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const GapH(2),
                  Hero(
                    tag: "brand:$heroTagAddition:${product.id}",
                    child: Text(
                      product.brand,
                      style: Get.textTheme.bodyText2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const GapH(6),
                  Text(
                    "\$${product.price}",
                    style: Get.textTheme.headline4!
                        .copyWith(color: Get.theme.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagsBuilder extends StatelessWidget {
  const TagsBuilder(
    this.tags, {
    Key? key,
  }) : super(key: key);

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 6,
        children: List.generate(
          tags.length,
          (index) => Container(
            decoration: BoxDecoration(
              color: Colors.purple.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Text(
              tags[index],
              style: Get.textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
