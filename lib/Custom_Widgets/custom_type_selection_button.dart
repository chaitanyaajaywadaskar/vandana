import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';

class CustomTypeSelecionButton extends StatelessWidget {
  CustomTypeSelecionButton(
      {super.key,
      required this.isTrue,
      required this.imageIcon,
      required this.tabName});

  bool isTrue;
  String imageIcon;
  String tabName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.072),
      height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstant.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.002, horizontal: Get.width * 0.004),
            height: Get.height * 0.034,
            width: Get.width * 0.072,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: ColorConstant.orange.withOpacity((isTrue) ? 1 : 0.5)),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.orange.withOpacity((isTrue) ? 1 : 0.5),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.058,
            width: Get.width * 0.122,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.orange,
                image: DecorationImage(image: NetworkImage(imageIcon))),
          ),
          Text(tabName,
              style: TextStyleConstant.medium26(color: ColorConstant.orange))
        ],
      ),
    );
  }
}

class CustomTypeText extends StatelessWidget {
  final String title;

  const CustomTypeText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: ColorConstant.white,
            size: Get.width * 0.036,
          ),
          SizedBox(height: Get.height * 0.018),
          SizedBox(
              width: Get.width * 0.8,
              child: Text(
                title,
                style: TextStyleConstant.bold16(),
              ))
        ],
      ),
    );
  }
}
