import 'package:ecommerce_getx/controller/auth/auth_controller.dart';
import 'package:ecommerce_getx/controller/auth/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/functions/functions.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_auth_button.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_auth_question.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_textformfield.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_title.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<RegisterController>(
          builder: (controller) {
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              children: [
                const GapH(50),
                Form(
                  key: controller.formKey,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 16,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomAuthTitleText(
                            "Register",
                            "Create Account To Start Buying",
                          ),
                          const GapH(50),
                          CustomTextFormField(
                            labelText: "Username",
                            hintText: "Enter Your Username",
                            icon: Icons.person_outline,
                            controller: controller.usernameController,
                            validator: (val) {
                              return AppFunctions.validateField(
                                val,
                                inputType: ValidatedInputType.username,
                              );
                            },
                          ),
                          const SizedBox(height: 25),
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
                          CustomTextFormField(
                            labelText: "Password",
                            hintText: "Enter Your Password",
                            icon: controller.isShowPassword.value
                                ? Icons.lock_open_outlined
                                : Icons.lock_outlined,
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.isShowPassword.value,
                            onTapIcon: () {
                              controller.isShowPassword.toggle();
                            },
                            validator: (val) {
                              return AppFunctions.validateField(
                                val,
                                // min: 5,
                                // max: 35,
                                inputType: ValidatedInputType.other,
                              );
                            },
                          ),
                          const SizedBox(height: 25),
                          CustomTextFormField(
                            labelText: "Confirm Password",
                            hintText: "Re Enter Your Password",
                            icon: controller.isShowConfirmPassword.value
                                ? Icons.lock_open_outlined
                                : Icons.lock_outlined,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                !controller.isShowConfirmPassword.value,
                            onTapIcon: () {
                              controller.isShowConfirmPassword.toggle();
                            },
                            validator: (val) {
                              if (val != controller.passwordController.text) {
                                return "Passwords Don't Match";
                              }
                              return null;
                            },
                          ),
                          const GapH(30),
                          controller.isLoading.value
                              ? const Loading()
                              : CustomAuthButton(
                                  text: "Register",
                                  onPressed: () {
                                    controller.register();
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),

                const GapH(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(Get.height),
                      onTap: () {
                        Get.find<AuthController>().loginWithGoogle();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/images/google.svg",
                        ),
                      ),
                    ),
                    const GapW(20),
                    InkWell(
                      borderRadius: BorderRadius.circular(Get.height),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/images/google.svg",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // const SizedBox(height: 15),
                CustomAuthQuestion(
                  text: "Have An Account?",
                  buttonText: "Login",
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
