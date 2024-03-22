import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return Center(
              child: Image.asset(ImagePathConstant.logo),
            );
          }),
    );
  }
}
