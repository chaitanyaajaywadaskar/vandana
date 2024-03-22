import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/get_otp_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/View/Authentication_Section/otp_view.dart';

class SignupController extends GetxController {
  GetOtpModel getOtpModel = GetOtpModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future getOtp() async {
    try {
      CustomLoader.openCustomLoader();
      Map<String, String> payload = {
        "phone": phoneController.text,
        "customer_name": nameController.text,
        "email": emailController.text
      };

      log("Get otp payload :::  $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.sendOtp, payload: payload);

      log("Get otp response ::: $response");

      getOtpModel = getOtpModelFromJson(response["body"]);

      if (getOtpModel.statusCode == "200" || getOtpModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        customToast(message: "${getOtpModel.message}");
        Get.to(() => OtpView(phone: phoneController.text));
        // Get.offAll(() => AddAddressScreen(fromAuth: true));
      } else {
        CustomLoader.closeCustomLoader();
        customToast(message: "${getOtpModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting otp ::: $error");
    }
  }
}
