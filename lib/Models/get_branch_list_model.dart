import 'dart:convert';

GetBranchListModel getBranchListModelFromJson(String str) =>
    GetBranchListModel.fromJson(json.decode(str));

String getBranchListModelToJson(GetBranchListModel data) =>
    json.encode(data.toJson());

class GetBranchListModel {
  String? statusCode;
  String? status;
  String? message;
  List<BranchList>? branchList;

  GetBranchListModel({
    this.statusCode,
    this.status,
    this.message,
    this.branchList,
  });

  factory GetBranchListModel.fromJson(Map<String, dynamic> json) =>
      GetBranchListModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        branchList: List<BranchList>.from(
            json["branch_list"].map((x) => BranchList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "branch_list": (branchList != null)
            ? List<dynamic>.from(branchList!.map((x) => x.toJson()))
            : null,
      };
}

class BranchList {
  String? id;
  String? branchName;
  String? address;
  String? loginId;
  String? latLong;

  BranchList({
    this.id,
    this.branchName,
    this.address,
    this.loginId,
    this.latLong,
  });

  factory BranchList.fromJson(Map<String, dynamic> json) => BranchList(
        id: json["id"],
        branchName: json["branch_name"],
        address: json["address"],
        loginId: json["login_id"],
        latLong: json["lat_long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName,
        "address": address,
        "login_id": loginId,
        "lat_long": latLong,
      };
}
