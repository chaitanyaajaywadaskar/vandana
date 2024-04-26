import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/profile_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_textfield.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Authentication_Section/address_view.dart';
import 'package:vandana/View/Initial_Section/get_start_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.initialFunctioun();
  }

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
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  ),
                ),
                SizedBox(height: Get.height * 0.024),
                Text(
                  'Name',
                  style: TextStyleConstant.bold14(),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                    controller: controller.nameController, enable: false),
                SizedBox(height: Get.height * 0.024),
                Text(
                  'Mobile Number',
                  style: TextStyleConstant.bold14(),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                    controller: controller.phoneController, enable: false),
                SizedBox(height: Get.height * 0.024),
                Text(
                  'Email',
                  style: TextStyleConstant.bold14(),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                    controller: controller.emailController, enable: false),
                SizedBox(height: Get.height * 0.024),
                Text(
                  'Address',
                  style: TextStyleConstant.bold14(),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: controller.addressController,
                  enable: false,
                ),
                SizedBox(height: Get.height * 0.024),
                InkWell(
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
                                    child: Obx(() {
                                      return ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: controller
                                            .getAddressListModel
                                            .value
                                            .addressList
                                            ?.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: ListTile(
                                              onTap: () async {
                                                controller.addressController
                                                        .text =
                                                    "${controller.getAddressListModel.value.addressList?[index]?.address}";
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
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.state,
                                                          pinCode: controller
                                                              .getAddressListModel
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.pincode,
                                                          latLng: controller
                                                              .getAddressListModel
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.latLong,
                                                          city: controller
                                                              .getAddressListModel
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.city,
                                                          addressType: controller
                                                              .getAddressListModel
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.addressType,
                                                          addressId: controller
                                                              .getAddressListModel
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.id,
                                                          address: controller
                                                              .getAddressListModel
                                                              .value
                                                              .addressList?[
                                                                  index]
                                                              ?.address,
                                                        ));
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              title: Text(
                                                  "${controller.getAddressListModel.value.addressList?[index]?.address}"),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    controller.removeAddress(
                                                        addressId:
                                                            "${controller.getAddressListModel.value.addressList?[index]?.id}");
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Manage your address',
                    style: TextStyleConstant.bold16(color: ColorConstant.blue),
                  ),
                ),

                SizedBox(height: Get.height * 0.024),

                // const Spacer(),
                CustomButton(
                  title: "Log Out",
                  onTap: () async {
                    await StorageServices.clearData();
                    customToast(message: "Log Out");
                    Get.offAll(() => const GetStartView());
                  },
                ),
                SizedBox(height: Get.height * 0.024),
              ],
            ),
          ),
        ));
  }
}
