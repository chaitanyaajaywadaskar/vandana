import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Controllers/select_tifin_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';
import 'package:vandana/Custom_Widgets/custom_type_selection_button.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Tifin_Section/tifin_detail_list_view.dart';

import '../../../../Custom_Widgets/type_selection_widget.dart';

class SelectTifinView extends StatelessWidget {
  const SelectTifinView({super.key});

  @override
  Widget build(BuildContext context) {
    List data = [
      "We provide daily choice of vegetables out of 20 sabjis",
      "Different menu for lunch and dinner",
      "Yoe can rechoice or change your vegetable/curry (Before 12 hours of the day)",
      "Free Cancelation with carry forward your tiffin (Before 12 hours of the day)",
      "Tiffin provide in dispossible meal tray for hygine purpose"
    ];
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      appBar: CustomAppBar(
        title: "Select Tifin",
        backGroundColor: ColorConstant.orange,
      ),
      body: GetBuilder<SelectTifinController>(
        init: SelectTifinController(),
        builder: (controller) {
          return Stack(
            children: [
              Positioned(
                  right: 0,
                  top: Get.height * 0.116,
                  bottom: Get.height * 0.346,
                  child: Image.asset(ImagePathConstant.rightShaeBg)),
              Positioned(
                  left: 0,
                  top: Get.height * 0.700,
                  bottom: Get.height * 0.100,
                  child: Image.asset(
                    ImagePathConstant.leftShapeBg,
                  )),
              (controller.getSubCategoryModel.subcategoryList != null)
                  ? SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: screenPadding,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller
                                  .getSubCategoryModel.subcategoryList?.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Get.to(() => TifinDetailListView(
                                      categoryName:
                                          "${controller.getSubCategoryModel.subcategoryList?[index].categoryName}",
                                      subCategoryName:
                                          "${controller.getSubCategoryModel.subcategoryList?[index].subcategoryName}")),
                                  child: Padding(
                                    padding: contentVerticalPadding,
                                    child: CustomTypeSelecionButton(
                                        isTrue: true,
                                        imageIcon:
                                            "${controller.getSubCategoryModel.subcategoryList?[index].subcategoryImage}",
                                        tabName:
                                            "${controller.getSubCategoryModel.subcategoryList?[index].subcategoryName}"),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: TypeText(data: data[index]),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CustomNoDataFound(),
            ],
          );
        },
      ),
    );
  }
}
