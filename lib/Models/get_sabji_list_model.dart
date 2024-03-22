import 'dart:convert';

GetSabjiListModel getSabjiListModelFromJson(String str) =>
    GetSabjiListModel.fromJson(json.decode(str));

String getSabjiListModelToJson(GetSabjiListModel data) =>
    json.encode(data.toJson());

class GetSabjiListModel {
  String? statusCode;
  String? status;
  String? message;
  List<SabjiList>? sabjiList;

  GetSabjiListModel({
    this.statusCode,
    this.status,
    this.message,
    this.sabjiList,
  });

  factory GetSabjiListModel.fromJson(Map<String, dynamic> json) =>
      GetSabjiListModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        sabjiList: List<SabjiList>.from(
            json["sabji_list"].map((x) => SabjiList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "sabji_list": List<dynamic>.from(sabjiList!.map((x) => x.toJson())),
      };
}

class SabjiList {
  String? id;
  String? sabji;

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
