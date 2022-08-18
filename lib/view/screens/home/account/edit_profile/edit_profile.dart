import 'package:ecommerce_getx/controller/home/account/edit_profile_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_textformfield.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/custom_sliver_layout.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<EditProfileController>(builder: (controller) {
        return CustomSliverLayout(
          title: "Edit Profile",
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  Text(
                    controller.userModel.email,
                    style: Get.textTheme.headline4,
                  ),
                  const GapH(25),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: Get.width * .23,
                        foregroundImage:
                            const AssetImage("assets/images/watch.png"),
                      ),
                      SizedBox(
                        width: Get.width * .23 * 2,
                        height: Get.width * .23 * 2,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(Get.height),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Change Image",
                              style: Get.textTheme.headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            const Icon(Icons.image, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const GapH(25),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "Username",
                          hintText: "Username",
                          controller: controller.usernameController,
                          validator: (val) {
                            return AppFunctions.validateField(
                              val,
                              min: 4,
                              inputType: ValidatedInputType.username,
                            );
                          },
                        ),
                        const GapH(25),
                        SizedBox(
                          width: double.infinity,
                          child: controller.isLoading
                              ? const Loading()
                              : CustomButton(
                                  text: "Save",
                                  onPressed: () {
                                    controller.saveChanges();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  const GapH(25),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.changePassword);
                    },
                    child: const Text("Change Password"),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
