import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/data/model/categoy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                child: SvgPicture.asset("assets/images/shoes_cat.svg"),
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
