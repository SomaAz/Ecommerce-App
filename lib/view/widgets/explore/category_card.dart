import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
    this.category, {
    Key? key,
  }) : super(key: key);
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.categoryDetails,
              arguments: category,
            );
          },
          child: Container(
            width: Get.height * .09,
            height: Get.height * .09,
            decoration: BoxDecoration(
              // shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Get.height),
              // ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 2),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                  // blurStyle: BlurStyle.outer,
                ),
              ],
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(25.0),
            child: CachedNetworkImage(
              imageUrl: category.image,
              fit: BoxFit.contain,
              placeholder: (_, __) => const ShimmerWidget(
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const GapH(5),
        Text(
          category.name.capitalizeFirst ?? category.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
