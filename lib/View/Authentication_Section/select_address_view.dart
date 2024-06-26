import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Controllers/select_address_controller.dart';
import 'package:vandana/Custom_Widgets/custom_appbar.dart';
import 'package:vandana/Custom_Widgets/custom_no_data_found.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Bottombar_Section/main_view.dart';

class SelectAddressView extends StatelessWidget {
  const SelectAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.backGround,
        appBar: CustomAppBar(
          title: "Select Address",
          leading: IconButton(
              onPressed: () {
                Get.to(() => const MainView());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ColorConstant.white,
              )),
        ),
        body: GetBuilder<SelectAddressController>(
          init: SelectAddressController(),
          builder: (controller) {
            return (controller.getAddressListModel.addressList != null)
                ? Padding(
                    padding: screenHorizontalPadding,
                    child: ListView.builder(
                      itemCount:
                          controller.getAddressListModel.addressList?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: contentVerticalPadding,
                          child: Card(
                            child: ListTile(
                              onTap: () async {
                                controller.latitude.value =
                                    '${controller.getAddressListModel.addressList?[index]?.latLong?.split(' ')[0]}';
                                controller.longitude.value =
                                    '${controller.getAddressListModel.addressList?[index]?.latLong?.split(' ')[1]}';
                                controller.getBranchList().then((value) async {
                                  if (value) {
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.address,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.address);
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.addressType,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.addressType);
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.city,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.city);
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.state,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.state);
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.latLng,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.latLong);
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.pinCode,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.pincode);
                                    await StorageServices.setData(
                                        dataType: StorageKeyConstant.stringType,
                                        prefKey: StorageKeyConstant.branch,
                                        stringData: controller
                                            .getAddressListModel
                                            .addressList?[index]?.city);
                                    Get.offAll(() => const MainView());
                                  } else {
                                    customToast(
                                        message:
                                            'Currently this branch is not available');
                                  }
                                });
                              },
                              title: Text(
                                  "${controller.getAddressListModel.addressList?[index]?.address}"),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const CustomNoDataFound();
          },
        ));
  }
}
