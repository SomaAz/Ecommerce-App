import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_getx/controller/product_details_controller.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: Get.height * .23,
            flexibleSpace: Hero(
              tag: "image:${controller.product.id}",
              child: Image.network(
                controller.product.image,
                fit: BoxFit.fill,
              ),
            ),
            actions: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.star_outline),
                  // color: Colors.white,
                  onPressed: () {},
                ),
              ),
              const GapW(15),
            ],
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: "name:${controller.product.id}",
                          child: Text(
                            controller.product.name,
                            style: Get.textTheme.headline2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const GapH(5),
                      SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: "brand:${controller.product.id}",
                          child: Text(
                            controller.product.brand,
                            style: Get.textTheme.headline4,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const GapH(5),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "In: ${controller.product.categoryName}",
                          style: Get.textTheme.headline5,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const GapH(30),
                      SizedBox(
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Flexible(
                              child: SizeSelectChip(),
                            ),
                            GapW(20),
                            Flexible(
                              child: ColorSelectChip(),
                            ),
                          ],
                        ),
                      ),
                      const GapH(20),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Description",
                          style: Get.textTheme.headline3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: "desc:${controller.product.id}",
                          child: Text(
                            controller.product.description,
                            style: Get.textTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // color: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: Get.statusBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style:
                      Get.textTheme.headline4!.copyWith(color: Colors.black54),
                ),
                Text(
                  "\$${controller.product.price}",
                  style: Get.textTheme.headline3!
                      .copyWith(color: Get.theme.primaryColor),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {},
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * .15,
                vertical: 15,
              ),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}

class ColorSelectChip extends StatelessWidget {
  const ColorSelectChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProductDetailsController>(
      builder: (controller) {
        controller.errorCloser.value;
        return DropdownButtonHideUnderline(
          child: DropdownButton2<Color>(
            value: controller.selectedColor.value,
            onChanged: controller.changeSelectedColor,
            items: controller.product.colors
                .map(
                  (color) => DropdownMenuItem(
                    value: color,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: color.withOpacity(1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(),
                      ),
                    ),
                  ),
                )
                .toList(),
            customButton: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Get.width),
                border: Border.all(color: Colors.black38),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Color",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: controller.selectedColor.value.withOpacity(1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SizeSelectChip extends StatelessWidget {
  const SizeSelectChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProductDetailsController>(
      builder: (controller) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: controller.selectedSize.value,
            onChanged: controller.changeSelectedSize,
            items: controller.product.sizes
                .map((size) => DropdownMenuItem(value: size, child: Text(size)))
                .toList(),
            customButton: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Get.width),
                border: Border.all(color: Colors.black38),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    controller.selectedSize.value,
                    style: Get.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
