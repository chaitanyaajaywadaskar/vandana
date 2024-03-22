// To parse this JSON data, do
//
//     final getPakagingDataModel = getPakagingDataModelFromJson(jsonString);

import 'dart:convert';

GetPakagingDataModel getPakagingDataModelFromJson(String str) => GetPakagingDataModel.fromJson(json.decode(str));

String getPakagingDataModelToJson(GetPakagingDataModel data) => json.encode(data.toJson());

class GetPakagingDataModel {
    final String? statusCode;
    final String? status;
    final String? message;
    final List<PackagingList>? packagingList;

    GetPakagingDataModel({
        this.statusCode,
        this.status,
        this.message,
        this.packagingList,
    });

    factory GetPakagingDataModel.fromJson(Map<String, dynamic> json) => GetPakagingDataModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        packagingList: json["packaging_list"] == null ? [] : List<PackagingList>.from(json["packaging_list"]!.map((x) => PackagingList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "packaging_list": packagingList == null ? [] : List<dynamic>.from(packagingList!.map((x) => x.toJson())),
    };
}

class PackagingList {
    final String? id;
    final String? packagingName;
    final String? description;
    final String? packagingPrice;

    PackagingList({
        this.id,
        this.packagingName,
        this.description,
        this.packagingPrice,
    });

    factory PackagingList.fromJson(Map<String, dynamic> json) => PackagingList(
        id: json["id"],
        packagingName: json["packaging_name"],
        description: json["description"],
        packagingPrice: json["packaging_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "packaging_name": packagingName,
        "description": description,
        "packaging_price": packagingPrice,
    };
}
