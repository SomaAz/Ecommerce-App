import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSliverLayout extends StatelessWidget {
  const CustomSliverLayout({
    required this.children,
    required this.title,
    this.child,
    this.actions,
    this.controller,
    Key? key,
  }) : super(key: key);
  final List<Widget> children;
  final String title;
  final List<Widget>? actions;
  final Widget? child;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: Get.height * .13,
          flexibleSpace: Column(
            children: [
              const Spacer(),
              AppBar(
                title: Text(title),
                actions: actions,
              ),
            ],
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
      ],
    );
  }
}
