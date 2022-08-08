import 'package:ecommerce_getx/controller/home/account/track_order_controller.dart';
import 'package:ecommerce_getx/data/model/order_tracking_model.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const _circleSize = 25.0;

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const heightRatio = .15;
    const itemsCount = 5;
    final heightOfLine = (Get.height * heightRatio - _circleSize);
    final heightOfTracker = (heightOfLine + _circleSize) * itemsCount;

    return Scaffold(
      body: GetBuilder<TrackOrderController>(
        builder: (controller) {
          return CustomSliverLayout(
            actions: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Get.theme.primaryColor,
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                  onPressed: controller.isRefreshing
                      ? null
                      : () async {
                          await controller.refreshData();
                        },
                ),
              ),
              const GapW(15),
            ],
            title: "Order No.${controller.order.number}",
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomStatusChangeIndicator(
                  trackings: controller.order.trackings,
                  currentStep: 0,
                  heightOfLine: heightOfLine,
                  heightOfTracker: heightOfTracker,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomStatusChangeIndicator extends StatelessWidget {
  const CustomStatusChangeIndicator({
    this.currentStep = 0,
    required this.trackings,
    required this.heightOfTracker,
    required this.heightOfLine,
    Key? key,
  }) : super(key: key);

  final int currentStep;
  final double heightOfTracker;
  final double heightOfLine;
  final List<OrderTrackingModel> trackings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: List.generate(
        //     itemsCount,
        //     (index) => currentStep < index
        //         ? const Text("\n")
        //         : Text(
        //             "2/8/2022\n10:00AM",
        //             style: Get.textTheme.bodyText1!.copyWith(height: 0),
        //           ),
        //   ),
        // ),
        const GapW(25),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            trackings.length,
            (index) {
              bool isLineActive;
              // if (index == 0) {
              //   isLineActive = false;
              // } else {
              isLineActive = trackings[index].timeChecked != null &&
                  trackings[index + 1].timeChecked != null;
              // }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  trackings[index].timeChecked == null
                      ? Text(
                          "00/00/0000\n00:00AM",
                          style: Get.textTheme.bodyText1!.copyWith(
                            height: 0,
                            color: Colors.transparent,
                          ),
                        )
                      : Text(
                          DateFormat("dd/MM/yyyy\nhh:mma")
                              .format(trackings[index].timeChecked!.toDate()),
                          style: Get.textTheme.bodyText1!.copyWith(height: 0),
                        ),
                  const GapW(25),
                  CustomStatusChangeNode(
                    hasLine: index < trackings.length - 1,
                    completed: trackings[index].timeChecked != null,
                    isLineActive: isLineActive,
                    activeColor: Get.theme.primaryColor,
                    inActiveColor: Colors.grey.shade400,
                    heightOfLine: heightOfLine,
                  ),
                  const GapW(25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trackings[index].title,
                        style: Get.textTheme.headline4,
                      ),
                      Text(
                        trackings[index].location,
                        style: TextStyle(
                          color: currentStep >= index ? Colors.black : null,
                          fontSize: currentStep >= index ? 14 : 13,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        // const GapW(25),
        // Container(
        //   // height: double.infinity,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: List.generate(
        //       itemsCount,
        //       (index) => Text(
        //         titles[index],
        //         style: TextStyle(
        //           color: currentStep >= index ? Colors.black : null,
        //           fontSize: currentStep >= index ? 14 : 13,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class CustomStatusChangeNode extends StatelessWidget {
  const CustomStatusChangeNode({
    this.hasLine = true,
    this.completed = false,
    this.isLineActive = false,
    this.activeColor = Colors.green,
    this.inActiveColor = Colors.grey,
    required this.heightOfLine,
    Key? key,
  }) : super(key: key);

  final bool hasLine;
  final bool completed;
  final bool isLineActive;
  final Color activeColor;
  final Color inActiveColor;
  final double heightOfLine;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.width),
            border: completed
                ? null
                : Border.all(
                    color: completed ? activeColor : inActiveColor,
                    width: 1,
                  ),
            color: completed ? activeColor : Colors.white,
          ),
        ),
        if (hasLine)
          Container(
            width: isLineActive ? 2 : 1.5,
            color: isLineActive ? activeColor : inActiveColor,
            height: heightOfLine,
          )
      ],
    );
  }
}
