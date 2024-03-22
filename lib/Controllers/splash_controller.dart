import 'dart:async';
import 'package:get/get.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Bottombar_Section/main_view.dart';
import 'package:vandana/View/Initial_Section/get_start_view.dart';

class SplashController extends GetxController {
  RxBool isAuthenticate = false.obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
    latitude.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.latitude) ??
        "";
    longitude.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.longitude) ??
        "";
    changeView();
  }

  changeView() async {
    Timer(const Duration(seconds: 3), () async {
      isAuthenticate.value = await StorageServices.getData(
              dataType: StorageKeyConstant.boolType,
              prefKey: StorageKeyConstant.isAuthenticate) ??
          false;

      if (isAuthenticate.value) {
        Get.offAll(() => const MainView());
      } else {
        Get.offAll(() => const GetStartView());
      }
    });
  }
}
