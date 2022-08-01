import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/product_model.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    Key? key,
  }) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: product);
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
                    tag: "image:${product.id}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.fill,
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
                    tag: "name:${product.id}",
                    child: Text(
                      product.name,
                      style: Get.textTheme.headline4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const GapH(2),
                  Hero(
                    tag: "brand:${product.id}",
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
