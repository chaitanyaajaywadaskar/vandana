import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:vandana/Constant/endpoint_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Custom_Widgets/custom_loader.dart';
import 'package:vandana/Custom_Widgets/custom_toast.dart';
import 'package:vandana/Models/post_address_model.dart';
import 'package:vandana/Models/post_edit_address_model.dart';
import 'package:vandana/Services/http_services.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Bottombar_Section/main_view.dart';

class AddressController extends GetxController {
  PostAddressModel postAddressModel = PostAddressModel();
  PostEditAddressModel postEditAddressModel = PostEditAddressModel();

  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController coordinatesController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxList<String> addressTypeList = ["Home", "Office"].obs;

  RxString userType = "".obs;
  RxString userCode = "".obs;
  RxString userPhone = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString selectedAddressType = "".obs;

  Position? position;
  Placemark placeMark = const Placemark();
  LatLng coordinates = const LatLng(0.0, 0.0);

  initialFunctioun() async {
    await getCurrentLocation();
    userType.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userType) ??
        "";
    userCode.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userCode) ??
        "";
    userPhone.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userPhone) ??
        "";
  }

  Future<Position> getCurrentLocation() async {
    CustomLoader.openCustomLoader();
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      coordinates = LatLng(position!.latitude, position!.longitude);

      log("Current coordinates ::: $coordinates");

      List<Placemark> placeMarkList = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);

      log("Place mark based on current coordinates ::: $placeMark");

      placeMark = placeMarkList[0];
      log("Place is :- $placeMark");
      addressController.text =
          "${placeMark.name}, ${placeMark.subThoroughfare}, ${placeMark.thoroughfare}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea} ${placeMark.postalCode}, ${placeMark.country}";
      await StorageServices.setData(
          dataType: StorageKeyConstant.stringType,
          prefKey: StorageKeyConstant.branch,
          stringData: placeMark.subLocality?.isEmpty == true
              ? placeMark.locality
              : placeMark.subLocality);
      stateController.text = placeMark.administrativeArea ?? "";
      cityController.text = placeMark.locality ?? "";
      pinCodeController.text = placeMark.postalCode ?? "";
      coordinatesController.text =
          "${coordinates.latitude} ${coordinates.longitude}";
      latitude.value = "${coordinates.latitude}";
      longitude.value = "${coordinates.longitude}";
      log("Current address ::: ${addressController.text}");
      update();
      CustomLoader.closeCustomLoader();

      return await Geolocator.getCurrentPosition();
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during getting current location and address ::: $error");
    }
    return await Geolocator.getCurrentPosition();
  }

  Future postAddress() async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "user_type": userType.value,
        "customer_code": userCode.value,
        "phone": userPhone.value,
        "address_type": selectedAddressType.value,
        "state": stateController.text,
        "city": cityController.text,
        "pincode": pinCodeController.text,
        "address": addressController.text,
        "lat_long": "${latitude.value} ${longitude.value}",
        "receivers_name": "Monika",
        "contact_no": "9325612162",
      };

      log("Post address payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addAddress, payload: payload);

      log("Post address response ::: $response");

      postAddressModel = postAddressModelFromJson(response["body"]);

      if (postAddressModel.statusCode == "200" ||
          postAddressModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();

        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.addressType,
            stringData: postAddressModel.addressDetails?.addressType);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.state,
            stringData: postAddressModel.addressDetails?.state);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.city,
            stringData: postAddressModel.addressDetails?.city);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.pinCode,
            stringData: postAddressModel.addressDetails?.pincode);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.address,
            stringData: postAddressModel.addressDetails?.address);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.latLng,
            stringData: postAddressModel.addressDetails?.latLong);

        customToast(message: "${postAddressModel.message}");

        Get.offAll(() => const MainView());
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting address ::: ${postAddressModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting address ::: $error");
    }
  }

  Future editAddress(
      {required String addressId,
      required String addressType,
      required String state,
      required String city,
      required String pinCode,
      required String address,
      required String latLng}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "id": addressId,
        "address_type": addressType,
        "state": state,
        "city": city,
        "pincode": pinCode,
        "address": address,
        "lat_long": latLng,
        "receivers_name": "Monika Gite",
        "contact_no": "9090909090",
      };

      log("Edit address payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addressEdit, payload: payload);

      log("Edit address response ::: $response");

      postEditAddressModel = postEditAddressModelFromJson(response["body"]);

      if (postEditAddressModel.statusCode == "200" ||
          postEditAddressModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();

        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.addressType,
            stringData: addressType);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.state,
            stringData: state);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.city,
            stringData: city);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.pinCode,
            stringData: pinCode);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.address,
            stringData: address);
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.latLng,
            stringData: latLng);

        customToast(message: "${postEditAddressModel.message}");

        Get.offAll(() => const MainView());
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting edit address ::: ${postEditAddressModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting edit address ::: $error");
    }
  }
}
