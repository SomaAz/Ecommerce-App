import 'package:ecommerce_getx/controller/auth/change_password_controller.dart';
import 'package:ecommerce_getx/view/screens/category_details.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_textformfield.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSliverLayout(
        title: "Change Password",
        children: [
          GetBuilder<ChangePasswordController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  children: [
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      labelText: "Email",
                      hintText: "Enter Your Email",
                      icon: Icons.email_outlined,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        return AppFunctions.validateField(
                          val,
                          inputType: ValidatedInputType.email,
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    controller.isLoading
                        ? const Loading()
                        : CustomButton(
                            text: "Send Link",
                            onPressed: () {
                              controller.sendResetPasswordEmail();
                            },
                          ),
                    const SizedBox(height: 15),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
