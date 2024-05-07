import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/image_path_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Controllers/address_controller.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Custom_Widgets/custom_textfield.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Services/form_validation_services.dart';
import 'package:vandana/View/Map_View/map_view.dart';

class AddressView extends StatefulWidget {
  final bool isEditAddress;
  final String? addressType;
  final String? addressId;
  final String? state;
  final String? city;
  final String? pinCode;
  final String? address;
  final String? latLng;

  const AddressView(
      {super.key,
      required this.isEditAddress,
      this.addressType,
      this.state,
      this.pinCode,
      this.address,
      this.latLng,
      this.city,
      this.addressId});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  AddressController controller = Get.put(AddressController());

  @override
  void initState() {
    super.initState();
    if (widget.isEditAddress) {
      controller.initialFunctioun();
      controller.selectedAddressType.value = widget.addressType!;
      controller.stateController.text = widget.state!;
      controller.cityController.text = widget.city!;
      controller.pinCodeController.text = widget.pinCode!;
      controller.addressController.text = widget.address!;
      controller.coordinatesController.text = widget.latLng!;
      controller.update();
    } else {
      controller.initialFunctioun();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        '${controller.selectedBranchCode.value} ${controller.selectedBranch.value} ');
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Get.height * 0.270,
              width: Get.width * 0.570,
              child: Image.asset(
                ImagePathConstant.address,
                fit: BoxFit.fill,
              ),
            ),
            Stack(
              children: [
                Image.asset(ImagePathConstant.addressBg),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: -2,
                    child: Image.asset(ImagePathConstant.bottomCurve)),
                Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.050,
                            bottom: Get.height * 0.040),
                        child: Text("ADDRESS",
                            style: TextStyleConstant.bold36(
                                color: ColorConstant.white)),
                      ),
                      DropdownMenu(
                          onSelected: (value) {
                            controller.selectedAddressType.value = value;
                            controller.update();
                          },
                          hintText: controller.selectedAddressType.value,
                          width: Get.width * 0.400,
                          dropdownMenuEntries: const <DropdownMenuEntry>[
                            DropdownMenuEntry(value: "Home", label: "Home"),
                            DropdownMenuEntry(value: "Office", label: "Office"),
                          ]),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.020),
                        child: CustomTextField(
                          controller: controller.stateController,
                          hintText: "State",
                          validator: FormValidationServices.validateField(
                              fieldName: "State Name"),
                        ),
                      ),
                      CustomTextField(
                        controller: controller.cityController,
                        hintText: "City",
                        validator: FormValidationServices.validateField(
                            fieldName: "City Name"),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.020),
                        child: CustomTextField(
                          controller: controller.pinCodeController,
                          hintText: "PinCode",
                          textInputType: TextInputType.number,
                          validator: FormValidationServices.validateField(
                              fieldName: "PinCode"),
                        ),
                      ),
                      CustomTextField(
                        controller: controller.addressController,
                        hintText: "Address",
                        validator: FormValidationServices.validateField(
                            fieldName: "Address"),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.020),
                        child: CustomTextField(
                          controller: controller.coordinatesController,
                          hintText: "Coordinates",
                          validator: FormValidationServices.validateField(
                              fieldName: "Coordinates"),
                        ),
                      ),
                      CustomButton(
                        title: "Select from Map",
                        onTap: () => Get.to(() => const MapScreen()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        title: "Get Current Location",
                        onTap: () => controller.getCurrentLocation(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.020),
                        child: CustomButton(
                          title: (widget.isEditAddress) ? "Edit" : "Save",
                          onTap: () async {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.selectedAddressType.value ==
                                      "Home" ||
                                  controller.selectedAddressType.value ==
                                      "Office") {
                                if (widget.isEditAddress) {
                                  // controller.getBranchList();
                                  controller.editAddress(
                                      addressId: "${widget.addressId}",
                                      addressType: "${widget.addressType}",
                                      state: "${widget.state}",
                                      city: "${widget.city}",
                                      pinCode: "${widget.pinCode}",
                                      address: "${widget.address}",
                                      latLng: "${widget.latLng}");
                                } else {
                                  // controller.getBranchList();
                                  controller.postAddress();
                                }
                              } else {
                                customToast(
                                    message: "Please Select Address Type");
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
