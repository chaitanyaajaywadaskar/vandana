import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Controllers/select_food_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';
import 'package:vandana/Custom_Widgets/custom_type_selection_button.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/food_detail_list_view.dart';
import 'package:vandana/View/Bottombar_Section/bottombar_view.dart';

class SelectFoodView extends StatefulWidget {
  const SelectFoodView({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<SelectFoodView> createState() => _SelectFoodViewState();
}

class _SelectFoodViewState extends State<SelectFoodView> {
  final foodController = Get.put(SelectFoodController());
  @override
  void initState() {
    super.initState();
    foodController.getSubCategory(categoryName: widget.categoryName);
  }

  String getTitle() {
    if (widget.categoryName == "Food") {
      return 'Select Food';
    } else if (widget.categoryName == "Thali With Chapati") {
      return 'Select Thali With Chapati';
    } else if (widget.categoryName == "Thali With Paratha") {
      return 'Select Thali With Paratha';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      appBar: CustomAppBar(
        title: getTitle(),
        backGroundColor: ColorConstant.orange,
        action: [
          IconButton(
              onPressed: () {
                Get.to(() => const BottomBarView(index: 1));
              },
              icon: const Icon(Icons.shopping_cart, color: ColorConstant.white))
        ],
      ),
      body: Obx(
        () {
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
              (foodController.getSubCategoryModel.value.subcategoryList != null)
                  ? Padding(
                      padding: screenPadding,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: foodController
                            .getSubCategoryModel.value.subcategoryList?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(() => FoodDetailListView(
                                categoryName:
                                    "${foodController.getSubCategoryModel.value.subcategoryList?[index].categoryName}",
                                subCategoryName:
                                    "${foodController.getSubCategoryModel.value.subcategoryList?[index].subcategoryName}")),
                            child: Padding(
                              padding: contentVerticalPadding,
                              child: CustomTypeSelecionButton(
                                  isTrue: true,
                                  imageIcon:
                                      "${foodController.getSubCategoryModel.value.subcategoryList?[index].subcategoryImage}",
                                  tabName:
                                      "${foodController.getSubCategoryModel.value.subcategoryList?[index].subcategoryName}"),
                            ),
                          );
                        },
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
