import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/food_detail_list_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_dotted_line.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Tifin_Section/tifin_billing_view.dart';

class TifinDetailListView extends StatefulWidget {
  final String categoryName;
  final String subCategoryName;

  const TifinDetailListView(
      {super.key, required this.categoryName, required this.subCategoryName});

  @override
  State<TifinDetailListView> createState() => _TifinDetailListViewState();
}

class _TifinDetailListViewState extends State<TifinDetailListView> {
  FoodDetailListController controller = Get.put(FoodDetailListController());

  @override
  void initState() {
    super.initState();
    controller.initialFunctioun();
    controller.categoryName.value = widget.categoryName;
    controller.subCategoryName.value = widget.subCategoryName;
    controller.getFoodDetail().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    controller.categoryName.value = '';
    controller.subCategoryName.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: const CustomAppBar(title: "Select Meal"),
      body: Stack(
        children: [
          Image.asset(
            ImagePathConstant.homeUpperBg,
            height: Get.height * 0.116,
          ),
          (controller.getFoodDetailListModel.value.productList != null)
              ? ListView.builder(
                  itemCount: controller
                      .getFoodDetailListModel.value.productList?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TifinBillingView(
                              productImage:
                                  "${controller.getFoodDetailListModel.value.productList?[index].productImage1}",
                              productName:
                                  "${controller.getFoodDetailListModel.value.productList?[index].productName}",
                              productDescription:
                                  "${controller.getFoodDetailListModel.value.productList?[index].description}",
                              mrp:
                                  "${controller.getFoodDetailListModel.value.productList?[index].mrp}",
                              price:
                                  "${controller.getFoodDetailListModel.value.productList?[index].price}",
                              categoryName:
                                  "${controller.getFoodDetailListModel.value.productList?[index].categoryName}",
                              subCategoryName:
                                  "${controller.getFoodDetailListModel.value.productList?[index].subcategoryName}",
                              cartId: "1",
                              productCode:
                                  "${controller.getFoodDetailListModel.value.productList?[index].productCode}",
                              tax:
                                  "${controller.getFoodDetailListModel.value.productList?[index].tax}",
                              total: "1",
                              unit: "nos",
                              taxjGst:
                                  "${controller.getFoodDetailListModel.value.productList?[index].tax}",
                              taxsGst:
                                  "${controller.getFoodDetailListModel.value.productList?[index].tax}",
                              weekendPrice:
                                  "${controller.getFoodDetailListModel.value.productList?[index].satSundayPrice}",
                              tifinCount:
                                  "${controller.getFoodDetailListModel.value.productList?[index].tiffinCount}",
                              subjiCount:
                                  "${controller.getFoodDetailListModel.value.productList?[index].subjiCount}",
                            ));
                      },
                      child: Padding(
                        padding: screenPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Get.width * 0.035),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: Get.height * 0.172,
                                        width: Get.width * 0.364,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${controller.getFoodDetailListModel.value.productList?[index].productImage1}"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.020),
                                        child: CustomButton(
                                          title:
                                              "Total Count: ${controller.getFoodDetailListModel.value.productList?[index].tiffinCount}",
                                          width: Get.width * 0.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.getFoodDetailListModel.value.productList?[index].productName}",
                                        style: TextStyleConstant.regular22(
                                            color: ColorConstant.orange),
                                      ),
                                      Text(
                                        "${controller.getFoodDetailListModel.value.productList?[index].description}",
                                        style: TextStyleConstant.regular16(
                                            color: ColorConstant.orangeAccent),
                                      ),
                                      Text(
                                        "${controller.getFoodDetailListModel.value.productList?[index].price}/-",
                                        style: TextStyleConstant.bold36(
                                            color: ColorConstant.orange),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.024),
                              child: const HorizontalDottedLine(),
                            ),
                            // height10,
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const CustomNoDataFound(),
        ],
      ),
    );
  }
}
