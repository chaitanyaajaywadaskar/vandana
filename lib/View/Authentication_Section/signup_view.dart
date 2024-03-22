import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/signup_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_textfield.dart';
import 'package:vandana/Services/form_validation_services.dart';
import 'package:vandana/View/Authentication_Section/login_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      body: GetBuilder<SignupController>(
          init: SignupController(),
          builder: (controller) {
            return Stack(
              children: [
                Positioned(
                    left: Get.width * 0.796,
                    top: Get.height * 0.700,
                    bottom: Get.height * 0.100,
                    child: Image.asset(ImagePathConstant.rightShaeBg)),
                Positioned(
                    right: Get.width * 0.450,
                    top: Get.height * 0.116,
                    bottom: Get.height * 0.346,
                    child: Image.asset(ImagePathConstant.leftShapeBg)),
                Form(
                  key: controller.formKey,
                  child: Center(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeightPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sign Up",
                            style: TextStyleConstant.bold24(
                                color: ColorConstant.white)),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.030,
                              bottom: Get.height * 0.010),
                          child: CustomTextField(
                            controller: controller.nameController,
                            hintText: "Name",
                            textInputType: TextInputType.name,
                            validator: FormValidationServices.validateField(
                                fieldName: "Name"),
                          ),
                        ),
                        CustomTextField(
                          controller: controller.phoneController,
                          hintText: "Phone",
                          textInputType: TextInputType.phone,
                          maxLength: 10,
                          validator: FormValidationServices.validatePhone(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.010,
                              bottom: Get.height * 0.030),
                          child: CustomTextField(
                            controller: controller.emailController,
                            hintText: "Email",
                            textInputType: TextInputType.emailAddress,
                            validator: FormValidationServices.validateEmail(),
                          ),
                        ),
                        CustomButton(
                          title: "Sign Up",
                          backGroundColor: ColorConstant.white,
                          textColor: ColorConstant.black,
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.getOtp();
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.030),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",
                                  style: TextStyleConstant.medium14(
                                      color: ColorConstant.white)),
                              GestureDetector(
                                onTap: () => Get.to(() => const LoginView()),
                                child: Text("Login",
                                    style: TextStyleConstant.bold14(
                                        color: ColorConstant.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            );
          }),
    );
  }
}
