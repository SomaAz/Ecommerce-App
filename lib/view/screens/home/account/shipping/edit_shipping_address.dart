import 'package:ecommerce_getx/controller/home/account/edit_shipping_address_controller.dart';
import 'package:ecommerce_getx/view/widgets/auth/custom_textformfield.dart';
import 'package:ecommerce_getx/view/widgets/custom_button.dart';
import 'package:ecommerce_getx/view/widgets/gap.dart';
import 'package:ecommerce_getx/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../widgets/custom_sliver_layout.dart';

class EditShippingAddressScreen extends StatelessWidget {
  const EditShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSliverLayout(
        title: "Edit Shipping Address",
        children: [
          GetBuilder<EditShippingAddressController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  children: [
                    CustomTextFormField(
                      labelText: "Address Name",
                      hintText: "Work address",
                      controller: controller.nameController,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    CustomTextFormField(
                      labelText: "Your Fullname",
                      hintText: "John Rock",
                      controller: controller.fullNameController,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          // if (!GetUtils.isUsername(val)) {
                          //   return "Enter A Valid Username";
                          // }
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    CustomTextFormField(
                      labelText: "Country",
                      hintText: "Palestine",
                      controller: controller.countryController,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    CustomTextFormField(
                      labelText: "State",
                      hintText: "Florida",
                      controller: controller.stateController,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    CustomTextFormField(
                      labelText: "City",
                      hintText: "Newyork city",
                      controller: controller.cityController,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(25),
                    CustomTextFormField(
                      labelText: "Street",
                      hintText: "222 weerdy flooper",
                      controller: controller.streetController,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          val = val.trim();
                          return null;
                        }
                        return "This Field Shouldn't Be Empty";
                      },
                    ),
                    const GapH(30),
                    controller.isLoading
                        ? const Loading()
                        : CustomButton(
                            text: "Save",
                            onPressed: () {
                              controller.editAddress();
                            },
                          ),
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
