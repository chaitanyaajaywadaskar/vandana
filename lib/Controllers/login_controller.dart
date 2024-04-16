import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/post_login_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Authentication_Section/select_address_view.dart';

import '../View/Bottombar_Section/main_view.dart';

class LoginController extends GetxController {
  PostLoginModel postLoginModel = PostLoginModel();

  TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future postLogin() async {
    var response;
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {"phone": phoneController.text};

      log("Post login payload :::  $payload");

      response = await HttpServices.postHttpMethod(
          url: EndPointConstant.login, payload: payload);

      log("Post login response ::: $response");

      postLoginModel = postLoginModelFromJson(response["body"]);
      if (postLoginModel.statusCode == "200" ||
          postLoginModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();

        await StorageServices.setData(
            dataType: StorageKeyConstant.boolType,
            prefKey: StorageKeyConstant.isAuthenticate,
            boolData: true);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userPhone,
            stringData: postLoginModel.result?.phone);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userEmail,
            stringData: postLoginModel.result?.email);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName,
            stringData: postLoginModel.result?.customerName);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userCode,
            stringData: postLoginModel.result?.customerCode);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userType,
            stringData: postLoginModel.result?.userType);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userId,
            stringData: postLoginModel.result?.id);

        customToast(message: "${postLoginModel.message}");
        Get.offAll(() => const MainView());

        // Get.offAll(() => const SelectAddressView());
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${postLoginModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      customToast(message: "phone or password wrong");

      log("Something went wrong during posting login ::: $response");
    }
  }
}
