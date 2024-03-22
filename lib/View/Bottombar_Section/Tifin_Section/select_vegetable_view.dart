import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';

class SelectVegetableView extends StatelessWidget {
  SelectVegetableView({super.key});

  RxList vegeTableList = [
    "Palak Paneer",
    "Palak Paneer Matar",
    "Paneer Methi Palak",
    "Matar Ki Sabzi",
    "Dry Aloo Matar",
    "Malay Kofta"
  ].obs;

  RxInt selectedVegetable = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      body: Stack(
        children: [
          Image.asset(
            ImagePathConstant.homeUpperBg,
            height: 100,
          ),
          Positioned(
              right: -50,
              top: Get.height * 0.75,
              child: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Image.asset(
                    ImagePathConstant.homeLowerBg,
                    height: 100,
                  ))),
          Padding(
            padding: screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // customHeight(Get.height * 0.1),
                Text(
                  "Select vegetable",
                  style: TextStyleConstant.bold40(color: ColorConstant.white),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.020, bottom: Get.height * 0.050),
                  child: Text(
                    "Today's Vegetable Offered",
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.bold32(color: ColorConstant.white),
                  ),
                ),
                // height20,
                // height20,
                ...List.generate(
                    vegeTableList.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(left: 50, bottom: 20),
                          child: Obx(
                            () => GestureDetector(
                              onTap: () {
                                selectedVegetable.value = index;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: selectedVegetable.value == index
                                                ? ColorConstant.white
                                                : ColorConstant.orangeAccent),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selectedVegetable == index
                                              ? ColorConstant.white
                                              : ColorConstant.orangeAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width * 0.048),
                                    Text(vegeTableList[index],
                                        style: TextStyleConstant.bold20())
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),

                // customHeight(40),
                Container(
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
                  child: Text("Select & Process",
                      style: TextStyleConstant.regular18(
                          color: ColorConstant.orange)),
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
      ),
    );
  }
}
