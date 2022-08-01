import 'package:ecommerce_getx/controller/home/cart/checkout/checkout_controller.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:status_change/status_change.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckoutController>(
        builder: (controller) {
          return CustomSliverLayout(
            title: "Checkout",
            children: [
              LinearStepIndicator(
                steps: controller.pages.length,
                controller: pageController,
                labels: List<String>.generate(
                  controller.pages.length,
                  (index) => "Step ${index + 1}",
                ),
                completedIcon: Icons.check_circle,
                complete: () {
                  print("hello");
                  return Future.value(true);
                },
              ),
              SizedBox(
                height: 20,
                child: PageView(
                  controller: pageController,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
              // Container(
              //   color: Colors. amber,
              //   height: 200,
              //   width: 500,
              //   child: StatusChange.tileBuilder(
              //     theme: StatusChangeThemeData(
              //       direction: Axis.horizontal,
              //       connectorTheme: const ConnectorThemeData(thickness: 1.0),
              //     ),
              //     builder: StatusChangeTileBuilder.connected(
              //       itemWidth: (_) =>
              //           Get.mediaQuery.size.width / controller.pages.length,
              //       contentWidgetBuilder: (_, __) => const SizedBox(),
              //       nameWidgetBuilder: (context, index) {
              //         return const Padding(
              //           padding: EdgeInsets.all(10),
              //           child: Text(
              //             'summary ',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         );
              //       },
              //       indicatorWidgetBuilder: (_, index) {
              //         if (index <= controller.pagesCurrentIndex) {
              //           return DotIndicator(
              //             size: 32.0,
              //             border: Border.all(color: Colors.green, width: 1),
              //             child: Padding(
              //               padding: const EdgeInsets.all(6.0),
              //               child: Container(
              //                 decoration: const BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.green,
              //                 ),
              //               ),
              //             ),
              //           );
              //         } else {
              //           return const OutlinedDotIndicator(
              //             size: 30,
              //             borderWidth: 1.0,
              //             color: Colors.grey,
              //           );
              //         }
              //       },
              //       lineWidgetBuilder: (index) {
              //         // if (index > 0) {
              //         return const SolidLineConnector(
              //           color: Colors.green,
              //         );
              //         // } else {
              //         //   return null;
              //         // }
              //       },
              //       itemCount: controller.pages.length,
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  if (controller.pagesCurrentIndex <
                      controller.pages.length - 1) {
                    controller.changepagesCurrentIndex(
                      controller.pagesCurrentIndex + 1,
                    );
                    pageController
                        .jumpTo(controller.pagesCurrentIndex.toDouble());
                  } else {
                    controller.changepagesCurrentIndex(
                      0,
                    );
                    pageController.jumpTo(0);
                  }
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
