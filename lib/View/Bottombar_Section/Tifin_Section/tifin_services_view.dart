import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/tifin_services_controller.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/thank_you_view.dart';
import 'package:vandana/View/Bottombar_Section/Tifin_Section/select_vegetable_view.dart';

class TifinServicesView extends StatelessWidget {
  const TifinServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFEF3EB),
        body: GetBuilder<TifinServicesController>(
            init: TifinServicesController(),
            builder: (controller) {
              return Stack(
                children: [
                  Positioned(
                      right: 0,
                      top: Get.height * -0.2,
                      left: Get.width * 0.38,
                      bottom: 200,
                      child: Image.asset(ImagePathConstant.rightShaeBg,
                          opacity: const AlwaysStoppedAnimation(0.5))),
                  Image.asset(ImagePathConstant.homeUpperBg),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.050,
                        left: screenWidthPadding,
                        right: screenWidthPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Hi, ${controller.userName.value}",
                          style: TextStyleConstant.bold32(
                              color: ColorConstant.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.100,
                              bottom: Get.height * 0.050),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Get.height * 0.172,
                                width: Get.width * 0.364,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ImagePathConstant.fullThali),
                                        fit: BoxFit.fill)),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Main Course Menu",
                                      style: TextStyleConstant.regular22(
                                          color: ColorConstant.orange)),
                                  Text(
                                    "2 Chapati, 2 sabji, \n1 plate Rise, Dal, Salad\n sweets, butter milk",
                                    style: TextStyleConstant.regular18(
                                        color: ColorConstant.orangeAccent),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: ColorConstant.orange)),
                              child: Text(
                                "Total Count",
                                style: TextStyleConstant.regular18(
                                    color: ColorConstant.orange),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SelectVegetableView());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                  color: ColorConstant.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "Select Vegetable",
                                  style: TextStyleConstant.regular18(
                                      color: ColorConstant.orange),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: screenVerticalPadding,
                          child: const HorizontalDottedLine(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ThankYouView(
                                  isCancelOrder: true,
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text("Cancel Tiffin",
                                style: TextStyleConstant.regular18(
                                    color: ColorConstant.orange)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(ImagePathConstant.bottomCurve)),
                ],
              );
            }));
  }
}
