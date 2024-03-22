// To parse this JSON data, do
//
//     final getSabjiDataModel = getSabjiDataModelFromJson(jsonString);

import 'dart:convert';

GetSabjiDataModel getSabjiDataModelFromJson(String str) => GetSabjiDataModel.fromJson(json.decode(str));

String getSabjiDataModelToJson(GetSabjiDataModel data) => json.encode(data.toJson());

class GetSabjiDataModel {
    final String? statusCode;
    final String? status;
    final String? message;
    final List<SabjiList>? sabjiList;

    GetSabjiDataModel({
        this.statusCode,
        this.status,
        this.message,
        this.sabjiList,
    });

    factory GetSabjiDataModel.fromJson(Map<String, dynamic> json) => GetSabjiDataModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        sabjiList: json["sabji_list"] == null ? [] : List<SabjiList>.from(json["sabji_list"]!.map((x) => SabjiList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "sabji_list": sabjiList == null ? [] : List<dynamic>.from(sabjiList!.map((x) => x.toJson())),
    };
}

class SabjiList {
    final String? id;
    final String? sabji;

    SabjiList({
        this.id,
        this.sabji,
    });

    factory SabjiList.fromJson(Map<String, dynamic> json) => SabjiList(
        id: json["id"],
        sabji: json["sabji"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sabji": sabji,
    };
}
