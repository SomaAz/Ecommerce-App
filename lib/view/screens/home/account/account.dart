import 'package:ecommerce_getx/controller/auth/auth_controller.dart';
import 'package:ecommerce_getx/controller/home/account/account_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AccountController>(builder: (controller) {
          if (controller.isLoading) return const Loading();
          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshData();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: Get.width * .16,
                      backgroundImage:
                          const AssetImage("assets/images/watch.png"),
                    ),
                    const GapW(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userModel!.username,
                          style: Get.textTheme.headline1!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          controller.userModel!.email,
                          style: Get.textTheme.headline5,
                        ),
                      ],
                    ),
                  ],
                ),
                const GapH(70),
                _AccountListTile(
                  imageName: "Icon_Edit-Profile",
                  onTap: () {
                    Get.toNamed(AppRoutes.editProfile);
                  },
                  title: 'Edit Profile',
                ),
                _AccountListTile(
                  imageName: "Icon_Location",
                  onTap: () {
                    Get.toNamed(AppRoutes.shippingAddress);
                  },
                  title: 'Shipping Address',
                ),
                _AccountListTile(
                  imageName: "Icon_History",
                  onTap: () {
                    // Get.toNamed(AppRoutes.shippingAddress);
                    Get.toNamed(AppRoutes.orders);
                  },
                  title: 'Orders History',
                ),
                _AccountListTile(
                  imageName: "Icon_Payment",
                  onTap: () {
                    Get.toNamed(AppRoutes.cards);
                  },
                  title: 'Cards',
                ),
                _AccountListTile(
                  imageName: "Icon_Alert",
                  onTap: () {
                    // Get.toNamed(AppRoutes.shippingAddress);
                  },
                  title: 'Notifications',
                ),
                _AccountListTile(
                  withTrailing: false,
                  imageName: "Icon_Exit",
                  onTap: () async {
                    await Get.find<AuthController>().signOut();
                  },
                  title: 'Logout',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _AccountListTile extends StatelessWidget {
  const _AccountListTile({
    Key? key,
    this.withTrailing = true,
    required this.imageName,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final bool withTrailing;

  final String imageName;
  final String title;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 25,
      iconColor: Colors.black,
      onTap: onTap,
      leading: Image.asset(
        "assets/images/account/$imageName.png",
        width: Get.width * .1,
        height: Get.width * .1,
        // cacheColorFilter: false,
        // colorBlendMode: BlendMode.src,
      ),
      title: Text(
        title,
        style: Get.textTheme.headline4!.copyWith(fontWeight: FontWeight.normal),
      ),
      trailing: withTrailing
          ? IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
              onPressed: () {},
            )
          : const Gap(),
    );
  }
}
