import 'package:get/get.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Services/storage_services.dart';

class TifinServicesController extends GetxController {
  RxString userName = "".obs;

  @override
  void onInit() {
    super.onInit();
    initialFunctioun();
  }

  initialFunctioun() async {
    userName.value = await StorageServices.getData(
        dataType: StorageKeyConstant.stringType,
        prefKey: StorageKeyConstant.userName);
  }
}
