import 'dart:convert';

GetPackagingListModel getPackagingListModelFromJson(String str) =>
    GetPackagingListModel.fromJson(json.decode(str));

String getPackagingListModelToJson(GetPackagingListModel data) =>
    json.encode(data.toJson());

class GetPackagingListModel {
  String? statusCode;
  String? status;
  String? message;
  List<PackagingList>? packagingList;

  GetPackagingListModel({
    this.statusCode,
    this.status,
    this.message,
    this.packagingList,
  });

  factory GetPackagingListModel.fromJson(Map<String, dynamic> json) =>
      GetPackagingListModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        packagingList: List<PackagingList>.from(
            json["packaging_list"].map((x) => PackagingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "packaging_list": (packagingList != null)
            ? List<dynamic>.from(packagingList!.map((x) => x.toJson()))
            : null,
      };
}

class PackagingList {
  String? id;
  String? packagingName;
  String? description;
  String? packagingPrice;

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
