import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Food_Section/select_food_view.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/Tifin_Section/select_tifin_view.dart';

import '../../Authentication_Section/address_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    controller.initialFunctioun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.backGround,
        body: SingleChildScrollView(
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
                            onPressed: () => ZoomDrawer.of(context)!.isOpen()
                                ? ZoomDrawer.of(context)!.close()
                                : ZoomDrawer.of(context)!.open(),
                            icon: Icon(Icons.menu,
                                color: ColorConstant.white,
                                size: Get.width * 0.098)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                               (){
                                return SizedBox(
                                  width: Get.width * 0.4,
                                  child: Text(
                                    " Hi, ${controller.userName.value}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConstant.bold20(
                                        color: ColorConstant.white),
                                  ),
                                );
                              }
                            ),
                            Obx(() {
                              return InkWell(
                                onTap: () {
                                  if (controller.getAddressListModel.value
                                              .addressList !=
                                          null &&
                                      controller.getAddressListModel.value
                                          .addressList!.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: Get.height,
                                          width: Get.width,
                                          child: AlertDialog(
                                            backgroundColor:
                                                ColorConstant.backGround,
                                            title: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () => Get.back(),
                                                    icon: const Icon(
                                                        Icons.arrow_back)),
                                                const Text("Select Address"),
                                              ],
                                            ),
                                            content: SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          const AddressView(
                                                            isEditAddress:
                                                                false,
                                                          ));
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        ),
                                                        Text("Add Address"),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.65,
                                                    child: ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount: controller
                                                          .getAddressListModel
                                                          .value
                                                          .addressList
                                                          ?.length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          child: ListTile(
                                                            onTap: () async {
                                                              controller.updateSelectedAddress(controller
                                                                      .getAddressListModel
                                                                      .value
                                                                      .addressList?[
                                                                          index]
                                                                      ?.id ??
                                                                  '');

                                                              controller
                                                                  .update();
                                                              Get.back();
                                                            },
                                                            // leading: IconButton(
                                                            //     onPressed: () {
                                                            //       Get.to(() =>
                                                            //           AddressView(
                                                            //             isEditAddress:
                                                            //                 true,
                                                            //             state: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.state,
                                                            //             pinCode: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.pincode,
                                                            //             latLng: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.latLong,
                                                            //             city: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.city,
                                                            //             addressType: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.addressType,
                                                            //             addressId: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.id,
                                                            //             address: controller
                                                            //                 .getAddressListModel
                                                            //                 .value
                                                            //                 .addressList?[index]
                                                            //                 ?.address,
                                                            //           ));
                                                            //     },
                                                            //     icon: const Icon(
                                                            //         Icons
                                                            //             .edit)),
                                                            title: Text(
                                                                "${controller.getAddressListModel.value.addressList?[index]?.address}"),
                                                            trailing:
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller.removeAddress(
                                                                          addressId:
                                                                              "${controller.getAddressListModel.value.addressList?[index]?.id}");
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .remove)),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    customToast(message: 'No address found');
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.3,
                                      child: Text(
                                        " ${controller.getSelectedAddressModel.value.UserSelectedAddress?.first?.address ?? ""}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyleConstant.semiBold18(
                                            color: ColorConstant.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
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
                              controller.getSelectedAddressModel.value
                                      .UserSelectedAddress?.first?.bname ??
                                  'Not Available',
                              textAlign: TextAlign.center,
                              style: TextStyleConstant.semiBold18(
                                  color: ColorConstant.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: SizedBox(
                          height: Get.height * 0.180,
                          width: Get.width,
                          child: (controller.getBannerImagesModel.bannerList !=
                                  null)
                              ? CarouselSlider.builder(
                                  itemCount: controller
                                      .getBannerImagesModel.bannerList?.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return CachedNetworkImage(
                                      imageUrl:
                                          "${controller.getBannerImagesModel.bannerList?[index].bannerImage}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: Get.width * 0.900,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill)),
                                      ),
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                        color: ColorConstant.orangeAccent,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    );
                                  },
                                  options: CarouselOptions(
                                      autoPlay: true, viewportFraction: 1))
                              : const CustomNoDataFound()),
                    ),
                    Text(
                      "Everyday",
                      style:
                          TextStyleConstant.bold24(color: ColorConstant.orange),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (controller.getCategoryListModel.categoryList !=
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
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (controller
                                            .getCategoryListModel
                                            .categoryList?[index]
                                            .categoryName ==
                                        "Tiffin") {
                                      Get.to(() => const SelectTifinView());
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
                                            color: Colors.grey.withOpacity(0.5),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              "${controller.getCategoryListModel.categoryList?[index].categoryName}",
                                              textAlign: TextAlign.center,
                                              style:
                                                  TextStyleConstant.semiBold22(
                                                      color: ColorConstant
                                                          .orangeAccent)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const CustomNoDataFound(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
