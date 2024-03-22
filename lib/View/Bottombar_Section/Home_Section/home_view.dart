import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/home_controller.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/select_food_view.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Tifin_Section/select_tifin_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.backGround,
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(ImagePathConstant.homeUpperBg),
                        Image.asset(ImagePathConstant.bottomCurve),
                      ],
                    ),
                    Padding(
                      padding: screenUpperHorizontalPadding,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      ZoomDrawer.of(context)!.isOpen()
                                          ? ZoomDrawer.of(context)!.close()
                                          : ZoomDrawer.of(context)!.open(),
                                  icon: Icon(Icons.menu,
                                      color: ColorConstant.white,
                                      size: Get.width * 0.098)),
                              SizedBox(
                                width: Get.width * 0.4,
                                child: Text(
                                  " Hi, ${controller.userName.value}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleConstant.bold24(
                                      color: ColorConstant.white),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                child: Container(
                                  padding: contentHorizontalPadding,
                                  height: Get.height * 0.060,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.orange,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: ColorConstant.transparent,
                                    ),
                                  ),
                                  child: Text(
                                    controller.selectedBranch.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyleConstant.semiBold18(
                                        color: ColorConstant.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: SizedBox(
                                height: Get.height * 0.180,
                                width: Get.width,
                                child: (controller
                                            .getBannerImagesModel.bannerList !=
                                        null)
                                    ? CarouselSlider.builder(
                                        itemCount: controller
                                            .getBannerImagesModel
                                            .bannerList
                                            ?.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          return Container(
                                            width: Get.width * 0.900,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "${controller.getBannerImagesModel.bannerList?[index].bannerImage}",
                                                    ),
                                                    fit: BoxFit.fill)),
                                          );
                                        },
                                        options: CarouselOptions(
                                            autoPlay: true,
                                            viewportFraction: 1))
                                    : const CustomNoDataFound()),
                          ),
                          Text(
                            "Everyday",
                            style: TextStyleConstant.bold24(
                                color: ColorConstant.orange),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (controller
                                        .getCategoryListModel.categoryList !=
                                    null)
                                ? GridView.builder(
                                    padding: const EdgeInsets.all(5),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 200,
                                            mainAxisExtent: Get.height * 0.2,
                                            childAspectRatio: 200 / 200,
                                            crossAxisSpacing: 25,
                                            mainAxisSpacing: 25),
                                    itemCount: controller.getCategoryListModel
                                            .categoryList?.length ??
                                        0,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext ctx, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (controller
                                                  .getCategoryListModel
                                                  .categoryList?[index]
                                                  .categoryName ==
                                              "Tiffin") {
                                            Get.to(
                                                () => const SelectTifinView());
                                          } else {
                                            Get.to(() => SelectFoodView(
                                                  categoryName:
                                                      '${controller.getCategoryListModel.categoryList?[index].categoryName}',
                                                ));
                                          }
                                        },
                                        child: Container(
                                          height: Get.height * 0.250,
                                          width: Get.width * 0.5,
                                          decoration: BoxDecoration(
                                              // borderRadius:
                                              //     BorderRadius.circular(1000),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                              color: ColorConstant.white),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: contentPadding,
                                                child: Container(
                                                  height: Get.width * 0.150,
                                                  width: Get.width * 0.150,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${controller.getCategoryListModel.categoryList?[index].categoryImage}"),
                                                          fit: BoxFit.fill)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                    "${controller.getCategoryListModel.categoryList?[index].categoryName}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyleConstant
                                                        .semiBold22(
                                                            color: ColorConstant
                                                                .orangeAccent)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : const CustomNoDataFound(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
