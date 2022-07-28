import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/controller/auth/forgot_password_controller.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_auth_button.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_textformfield.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Forgot Password",
        ),
      ),
      body: GetX<ForgotPasswordController>(
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
                controller.isLoading.value
                    ? const Loading()
                    : CustomAuthButton(
                        text: "Send Code",
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
    );
  }
}
