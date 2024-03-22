import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/View/Bottombar_Section/main_view.dart';

class ThankYouView extends StatelessWidget {
  final bool isCancelOrder;

  const ThankYouView({super.key, required this.isCancelOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isCancelOrder)
              ? Image.asset(
                  ImagePathConstant.orderCancel,
                  height: Get.height * 0.5,
                )
              : Image.asset(
                  ImagePathConstant.thankYou,
                  height: Get.height * 0.5,
                ),
          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.024, bottom: Get.height * 0.060),
            child: Text(
              (isCancelOrder)
                  ? "Your Order has\nbeen Cancelled".toUpperCase()
                  : "THANK\nYOU!".toUpperCase(),
              textAlign: TextAlign.center,
              style: (isCancelOrder)
                  ? TextStyleConstant.bold40()
                  : TextStyleConstant.bold60(),
            ),
          ),
          Padding(
            padding: screenHorizontalPadding,
            child: CustomButton(
              title: "Next",
              textColor: ColorConstant.orange,
              backGroundColor: ColorConstant.white,
              onTap: () => Get.offAll(() => const MainView()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Image.asset(ImagePathConstant.bottomCurve),
    );
  }
}
