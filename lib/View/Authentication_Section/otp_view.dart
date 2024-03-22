import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/otp_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_textfield.dart';
import 'package:vandana/Services/form_validation_services.dart';

class OtpView extends StatelessWidget {
  final String phone;

  const OtpView({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      body: GetBuilder<OtpController>(
          init: OtpController(),
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
                        Text("Verify Otp",
                            style: TextStyleConstant.bold24(
                                color: ColorConstant.white)),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.030,
                              bottom: Get.height * 0.030),
                          child: CustomTextField(
                            controller: controller.otpController,
                            hintText: "Otp",
                            textInputType: TextInputType.number,
                            validator: FormValidationServices.validateField(
                                fieldName: "Otp"),
                          ),
                        ),
                        CustomButton(
                          title: "Verify Otp",
                          backGroundColor: ColorConstant.white,
                          textColor: ColorConstant.black,
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.postVerifyOtp(phone: phone);
                            }
                          },
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
