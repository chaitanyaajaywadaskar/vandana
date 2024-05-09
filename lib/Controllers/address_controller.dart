import 'dart:developer';
import 'dart:math' as math;
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

import '../Models/get_branch_list_model.dart';
import '../Models/post_selected_address_model.dart';

class AddressController extends GetxController {
  PostAddressModel postAddressModel = PostAddressModel();
  PostSelectedAddressModel postSelectedAddressModel =
      PostSelectedAddressModel();
  PostEditAddressModel postEditAddressModel = PostEditAddressModel();

  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController coordinatesController = TextEditingController();
  RxString selectedBranch = "".obs;
  RxString selectedBranchCode = "".obs;

  final formKey = GlobalKey<FormState>();
  GetBranchListModel getBranchListModel = GetBranchListModel();

  RxList<String> addressTypeList = ["Home", "Office"].obs;

  RxString userType = "".obs;
  RxString userName = "".obs;
  RxString userCode = "".obs;
  RxString userPhone = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString selectedAddressType = "".obs;
  RxDouble distance = 0.0.obs;

  Position? position;
  Placemark placeMark = const Placemark();
  LatLng coordinates = const LatLng(0.0, 0.0);

  initialFunctioun() async {
    getBranchList().then((value) {
      getCurrentLocation();
    });

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
    userName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName) ??
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
      log('locality:- ${placeMark.locality} sublocality:- ${placeMark.subLocality}');

      stateController.text = placeMark.administrativeArea ?? "";
      cityController.text = placeMark.locality ?? "";
      pinCodeController.text = placeMark.postalCode ?? "";
      coordinatesController.text =
          "${coordinates.latitude} ${coordinates.longitude}";
      latitude.value = "${coordinates.latitude}";
      longitude.value = "${coordinates.longitude}";

      bool isContain = getBranchListModel.branchList?.any((element) =>
              element?.branchName.toString().trim().toLowerCase() ==
              placeMark.subLocality.toString().trim().toLowerCase()) ??
          false;
      if (isContain) {
        selectedBranch.value = placeMark.subLocality ?? 'Not Available';
        getBranchListModel.branchList?.forEach((element) {
          if (element?.branchName.toString().trim().toLowerCase() ==
              placeMark.subLocality.toString().trim().toLowerCase()) {
            selectedBranchCode.value = element?.loginId ?? '';
          }
        });

        log('contain data:------------>>> ${selectedBranchCode.value}');
      } else {
        log('not contain data:------------>>> ${selectedBranchCode.value}');

        selectedBranch.value = 'Not Available';
      }

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

  // String? getClosestBranch(
  //   Position position,
  // ) {
  //   // We'll calculate the distance between the device's position and each branch
  //   double minDistance = double.infinity;
  //   String? closestBranch;

  //   for (var branchInfo in getBranchListModel.branchList!) {
  //     String branchName = branchInfo?.branchName?.toString() ?? '';
  //     // For simplicity, we'll just assume branch locations based on latitude and longitude
  //     // You would typically have the latitude and longitude of each branch
  //     double branchLatitude = 18.5204; // Example latitude of the branch
  //     double branchLongitude = 73.8567; // Example longitude of the branch

  //     double distance = Geolocator.distanceBetween(position.latitude,
  //         position.longitude, branchLatitude, branchLongitude);
  //     if (distance < minDistance) {
  //       minDistance = distance;
  //       closestBranch = branchName;
  //     }
  //   }

  //   return closestBranch;
  // }

  Future getBranchList() async {
    try {
      CustomLoader.openCustomLoader();

      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.branchList);

      debugPrint("Get branch list response ::: $response");

      getBranchListModel = getBranchListModelFromJson(response["body"]);

      if (getBranchListModel.statusCode == "200" ||
          getBranchListModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        // for (int i = 0;
        //     i < int.parse('${getBranchListModel.branchList?.length ?? 0}');
        //     i++) {
        //   distance.value = calculateDistance(
        //       double.parse(latitude.value),
        //       double.parse(longitude.value),
        //       double.parse(
        //           "${getBranchListModel.branchList?[i]?.latLong?.split(", ")[0]}"),
        //       double.parse(
        //           "${getBranchListModel.branchList?[i]?.latLong?.split(", ")[1]}"));

        //   if (distance.value <= 7) {
        //     await StorageServices.setData(
        //         dataType: StorageKeyConstant.stringType,
        //         prefKey: StorageKeyConstant.branch,
        //         stringData: getBranchListModel.branchList?[i]?.branchName);
        //     selectedBranch.value =
        //         '${getBranchListModel.branchList?[i]?.branchName}';
        //   } else {
        //     debugPrint('not contain');
        //   }
        // }

        update();
      } else {
        CustomLoader.closeCustomLoader();
        debugPrint(
            "Something went wrong during getting branch list ::: ${getBranchListModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting branch list ::: $error");
    }
  }

  // double degreesToRadians(double degrees) {
  //   return degrees * pi / 180.0;
  // }

  // double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  //   double dLat = degreesToRadians(lat2 - lat1);
  //   double dLon = degreesToRadians(lon2 - lon1);

  //   double a = math.pow(math.sin(dLat / 2), 2) +
  //       math.cos(degreesToRadians(lat1)) *
  //           math.cos(degreesToRadians(lat2)) *
  //           math.pow(math.sin(dLon / 2), 2);

  //   double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  //   return earthRadius * c;
  // }

  Future postAddress({bool isFromTIffin = false}) async {
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
        "receivers_name": userName.value,
        "contact_no": userPhone.value,
        "branch": selectedBranchCode.value.isNotEmpty
            ? selectedBranchCode.value
            : 'Not Available'
      };

      log("Post address payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.addAddress, payload: payload);

      log("Post address response ::: $response");

      postAddressModel = postAddressModelFromJson(response["body"]);

      if (postAddressModel.statusCode == "200" ||
          postAddressModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        updateSelectedAddress(postAddressModel.addressDetails?.id ?? '',
            isFromTIffin: isFromTIffin);
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
        await StorageServices.setData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.branch,
            stringData: selectedBranchCode.value);
        customToast(message: "${postAddressModel.message}");
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during posting address ::: ${postAddressModel.message}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      log("Something went wrong during posting address ::: $error");
    }
  }

  Future updateSelectedAddress(String id, {bool isFromTIffin = false}) async {
    CustomLoader.openCustomLoader();
    try {
      Map<String, dynamic> payload = {
        "id": id,
        "customer_code": userCode.value,
        "address_status": "selected",
      };

      log("Post selected address payload ::: $payload");

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.selectedAddressUpdate, payload: payload);

      log("Post selected address response ::: $response");

      postSelectedAddressModel =
          postSelectedAddressModelFromJson(response["body"]);

      if (postSelectedAddressModel.statusCode == "200" ||
          postSelectedAddressModel.statusCode == "201") {
        CustomLoader.closeCustomLoader();
        if (isFromTIffin) {
          Get.back();
        } else {
          Get.offAll(() => const MainView());
        }
        // customToast(message: "${postSelectedAddressModel.message}");
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
        "receivers_name": userName.value,
        "contact_no": userPhone.value,
        "branch": selectedBranchCode.value.isNotEmpty
            ? selectedBranchCode.value
            : 'Not Available'
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
