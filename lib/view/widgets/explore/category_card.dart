import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
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
        SizedBox(
          width: Get.height * .09,
          height: Get.height * .09,
          child: GestureDetector(
            onTap: () {
              // final categoryDetailsGetPage = AppRoutes.getPages.firstWhere(
              //   (getPage) => getPage.name == AppRoutes.categoryDetails,
              // );

              Get.toNamed(
                AppRoutes.categoryDetails,
                arguments: category,
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Get.height),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CachedNetworkImage(
                  imageUrl: category.image,
                  // fit: BoxFit.contain,
                  placeholder: (_, __) => const ColoredBox(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        Text(
          category.name,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
