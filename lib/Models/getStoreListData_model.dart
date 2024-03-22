// To parse this JSON data, do
//
//     final getStoreListDataModel = getStoreListDataModelFromJson(jsonString);

import 'dart:convert';

GetStoreListDataModel getStoreListDataModelFromJson(String str) => GetStoreListDataModel.fromJson(json.decode(str));

String getStoreListDataModelToJson(GetStoreListDataModel data) => json.encode(data.toJson());

class GetStoreListDataModel {
    final String? statusCode;
    final String? status;
    final String? message;
    final List<BranchList>? branchList;

    GetStoreListDataModel({
        this.statusCode,
        this.status,
        this.message,
        this.branchList,
    });

    factory GetStoreListDataModel.fromJson(Map<String, dynamic> json) => GetStoreListDataModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        branchList: json["branch_list"] == null ? [] : List<BranchList>.from(json["branch_list"]!.map((x) => BranchList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "branch_list": branchList == null ? [] : List<dynamic>.from(branchList!.map((x) => x.toJson())),
    };
}

class BranchList {
    final String? id;
    final String? branchName;
    final String? address;
    final String? loginId;
    final String? latLong;
     bool? isAvailable;

    BranchList({
        this.id,
        this.branchName,
        this.address,
        this.loginId,
        this.latLong,
        this.isAvailable,
    });

    factory BranchList.fromJson(Map<String, dynamic> json) => BranchList(
        id: json["id"],
        branchName: json["branch_name"],
        address: json["address"],
        loginId: json["login_id"],
        latLong: json["lat_long"],
        isAvailable: false
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName,
        "address": address,
        "login_id": loginId,
        "lat_long": latLong,
    };
}
