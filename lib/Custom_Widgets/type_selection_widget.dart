// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/textstyle_constant.dart';

import '../Constant/color_constant.dart';
import '../Constant/static_decoration.dart';

class TypeSelectionWidgteScreen extends StatelessWidget {
  TypeSelectionWidgteScreen(
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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: ColorConstant.appMainColor
                          .withOpacity(isTrue == true ? 1 : 0.5)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.appMainColor
                        .withOpacity(isTrue == true ? 1 : 0.5),
                  ),
                ),
              ),
              customWidth(Get.width * 0.2),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: ColorConstant.appMainColor),
                child: Image.asset(
                  imageIcon,
                  // height: 90,
                  // width: 90,
                ),
              ),
            ],
          ),
          Text(
            tabName,
            style: TextStyleConstant.semiBold26().copyWith(
                color: ColorConstant.appMainColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class TypeText extends StatelessWidget {
  TypeText({super.key, required this.data});
  String? data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: primaryWhite,
            size: 15,
          ),
          width15,
          SizedBox(
              width: Get.width * 0.8,
              child: Text(
                data!,
                style: TextStyleConstant.medium16(),
              ))
        ],
      ),
    );
  }
}
