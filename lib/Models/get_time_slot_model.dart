import 'dart:convert';
import 'package:get/get.dart';

GetTimeSlotModel getTimeSlotModelFromJson(String str) =>
    GetTimeSlotModel.fromJson(json.decode(str));

String getTimeSlotModelToJson(GetTimeSlotModel data) =>
    json.encode(data.toJson());

class GetTimeSlotModel {
  String? statusCode;
  String? status;
  String? message;
  List<TimeslotList>? timeslotList;

  GetTimeSlotModel({
    this.statusCode,
    this.status,
    this.message,
    this.timeslotList,
  });

  factory GetTimeSlotModel.fromJson(Map<String, dynamic> json) =>
      GetTimeSlotModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        timeslotList: List<TimeslotList>.from(
            json["timeslot_list"].map((x) => TimeslotList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "timeslot_list":
            List<dynamic>.from(timeslotList!.map((x) => x.toJson())),
      };
}

class TimeslotList {
  String? id;
  String? tiffinType;
  String? timeslot;
  RxBool? isSelected = false.obs;

  TimeslotList({
    this.id,
    this.tiffinType,
    this.timeslot,
    this.isSelected,
  });

  factory TimeslotList.fromJson(Map<String, dynamic> json) => TimeslotList(
        id: json["id"],
        tiffinType: json["tiffin_type"],
        timeslot: json["timeslot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tiffin_type": tiffinType,
        "timeslot": timeslot,
        "isSelected": isSelected
      };
}
