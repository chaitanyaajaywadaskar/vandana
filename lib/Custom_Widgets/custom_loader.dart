import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';

class CustomLoader {
  static void openCustomLoader() {
    Future.delayed(const Duration(milliseconds: 0), () {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Center(
                child: CircularProgressIndicator(color: ColorConstant.orange),
              ),
            );
          });
    });
  }

  static void closeCustomLoader() {
    Get.back();
  }
}
