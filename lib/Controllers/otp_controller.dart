import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/post_verify_otp_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Authentication_Section/address_view.dart';

class OtpController extends GetxController {
  PostVerifyOtpModel postVerifyOtpModel = PostVerifyOtpModel();

  TextEditingController otpController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future postVerifyOtp({required String phone}) async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "phone": phone,
        "otp": otpController.text,
      };

      log("Post verify otp payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.verifyOtp, payload: payload);

      log("Post verify otp response ::: $response");

      postVerifyOtpModel = postVerifyOtpModelFromJson(response["body"]);

      if (postVerifyOtpModel.statusCode == "200" ||
          postVerifyOtpModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();

        await StorageServices.setData(
            dataType: StorageKeyConstant.boolType,
            prefKey: StorageKeyConstant.isAuthenticate,
            boolData: true);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userPhone,
            stringData: postVerifyOtpModel.registerDetails?.phone);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userEmail,
            stringData: postVerifyOtpModel.registerDetails?.email);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName,
            stringData: postVerifyOtpModel.registerDetails?.customerName);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userCode,
            stringData: postVerifyOtpModel.registerDetails?.customerCode);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userType,
            stringData: postVerifyOtpModel.registerDetails?.userType);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userId,
            stringData: postVerifyOtpModel.registerDetails?.id);

        customToast(message: "${postVerifyOtpModel.message}");
        Get.offAll(() => const AddressView(isEditAddress: false));
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postVerifyOtpModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting verify otp ::: $error");
    }
  }
}
