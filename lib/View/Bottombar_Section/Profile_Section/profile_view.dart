import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Controllers/profile_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_textfield.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Authentication_Section/address_view.dart';
import 'package:vandana/View/Initial_Section/get_start_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backGround,
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: ColorConstant.white),
        ),
        backgroundColor: ColorConstant.orangeAccent,
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    maxRadius: 70,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  ),
                  SizedBox(height: Get.height * 0.024),
                  CustomTextField(
                      controller: controller.nameController, enable: false),
                  SizedBox(height: Get.height * 0.024),
                  CustomTextField(
                      controller: controller.phoneController, enable: false),
                  SizedBox(height: Get.height * 0.024),
                  CustomTextField(
                      controller: controller.emailController, enable: false),
                  SizedBox(height: Get.height * 0.024),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: AlertDialog(
                              backgroundColor: ColorConstant.backGround,
                              title: Row(
                                children: [
                                  IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.arrow_back)),
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
                                        Get.to(() => const AddressView(
                                              isEditAddress: false,
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
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: controller
                                            .getAddressListModel
                                            .addressList
                                            ?.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: ListTile(
                                              onTap: () async {
                                                controller.addressController
                                                        .text =
                                                    "${controller.getAddressListModel.addressList?[index]?.address}";
                                                await controller
                                                    .setAddressDetail(
                                                        index: index);

                                                controller.update();
                                                Get.back();
                                              },
                                              leading: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddressView(
                                                          isEditAddress: true,
                                                          state: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.state,
                                                          pinCode: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.pincode,
                                                          latLng: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.latLong,
                                                          city: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.city,
                                                          addressType: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.addressType,
                                                          addressId: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.id,
                                                          address: controller
                                                              .getAddressListModel
                                                              .addressList?[
                                                                  index]
                                                              ?.address,
                                                        ));
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              title: Text(
                                                  "${controller.getAddressListModel.addressList?[index]?.address}"),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    controller.removeAddress(
                                                        addressId:
                                                            "${controller.getAddressListModel.addressList?[index]?.id}");
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove)),
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
                    },
                    child: CustomTextField(
                      controller: controller.addressController,
                      enable: false,
                      suffixIcon: const Icon(Icons.edit),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    title: "Log Out",
                    onTap: () async {
                      await StorageServices.clearData();
                      customToast(message: "Log Out");
                      Get.offAll(() => const GetStartView());
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
