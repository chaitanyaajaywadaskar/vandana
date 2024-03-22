import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/View/Authentication_Section/signup_view.dart';

class GetStartView extends StatelessWidget {
  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImagePathConstant.getStartBg,
            height: Get.height * 0.7,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 0, left: screenWidthPadding, right: screenWidthPadding),
            child: Text("Enjoy Eating",
                style: TextStyleConstant.bold32(color: ColorConstant.orange)),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 15, left: screenWidthPadding, right: screenWidthPadding),
            child: Text("All the delicious food on your phone",
                style: TextStyleConstant.bold20(color: ColorConstant.orange)),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
                bottom: screenHeightPadding,
                left: screenWidthPadding,
                right: screenWidthPadding),
            child: CustomButton(
              title: "Get Started",
              onTap: () => Get.offAll(() => const SignupView()),
            ),
          ),
        ],
      ),
    );
  }
}
